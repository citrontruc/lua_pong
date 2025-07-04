-- An object to deliminate our screen to a grid and help limit the number of collisions to test
-- The grid divides our screen in squares so that we can do local comparisons between items

local Grid = {}
Grid.__index = Grid


function Grid:new(cell_size_x, cell_size_y)
    local object = {
        cell_size_x = cell_size_x,
        cell_size_y = cell_size_y,
        num_cell_x = math.floor(love.graphics.getWidth() / cell_size_x),
        num_cell_y = math.floor(love.graphics.getHeight() / cell_size_y),
        list_object = {},
        list_evaluate_collision = {}
    }
    setmetatable(object, Grid)
    return object
end

-- We assign an object to our grid
function Grid:assign(object)
    table.insert(self.list_object, object)
end

-- Getter function
function Grid:get_objects()
    return self.list_object
end

function Grid:update()
    self:update_cells()
    self:evaluate_collision()
end

function Grid:reset_cells()
    self.list_evaluate_collision = {}
    for x = 1, self.num_cell_x do
        for y = 1, self.num_cell_y do
            self.list_evaluate_collision[x .. "-" .. y] = {}
        end
    end
end

-- For every item, we assign them a cell
function Grid:update_cells()
    self:reset_cells()
    for key, object in pairs(self.list_object) do
        local cell_x = math.floor(object.x / self.cell_size_x) + 1
        local cell_y = math.floor(object.y / self.cell_size_y) + 1
        table.insert(self.list_evaluate_collision[cell_x .. "-" .. cell_y], key)
    end
end

-- We evaluate the collisions between items of adjacent cells
function Grid:evaluate_collision()
    for x = 1, self.num_cell_x do
        for y = 1, self.num_cell_y do
            -- Get a list of all the items to compare against by checking the cell to the right, the bottom and diagonal
            local other_objects_to_evaluate = {}
            for _, v in pairs(self.list_evaluate_collision[x .. "-" .. y]) do
                    table.insert(other_objects_to_evaluate, v)
                end
            if x ~= self.num_cell_x then
                for _, v in pairs(self.list_evaluate_collision[x+1 .. "-" .. y]) do
                    table.insert(other_objects_to_evaluate, v)
                end
            end
            if y ~= self.num_cell_y then 
                for _, v in pairs(self.list_evaluate_collision[x .. "-" .. y+1]) do
                    table.insert(other_objects_to_evaluate, v) 
                end
            end
             if x ~= self.num_cell_x and y ~= self.num_cell_y then 
                for _, v in pairs(self.list_evaluate_collision[x+1 .. "-" .. y+1]) do
                    table.insert(other_objects_to_evaluate, v) 
                end
            end
            -- Do all our comparisons
            for num_val = 1, #self.list_evaluate_collision[x .. "-" .. y] do
                for num_val_compare = num_val, #other_objects_to_evaluate do
                    self:compare_collision(
                        self.list_object[self.list_evaluate_collision[x .. "-" .. y][num_val]], 
                        self.list_object[other_objects_to_evaluate[num_val_compare]])
                end
            end
        end
    end
end

-- If two items collide, apply collision effects to both items.
-- If an item has special properties (example: not pushable), apply special collision.
function Grid:compare_collision(object_1, object_2)
    local dx = object_1.x - object_2.x
    local dy = object_1.y - object_2.y
    local overlap_x = (object_1.size_x + object_2.size_x)/2 - math.abs(dx)
    local overlap_y = (object_1.size_y + object_2.size_y)/2 - math.abs(dy)

    if overlap_x > 0 and overlap_y > 0 then
        -- Resolve smaller overlap axis first
        if overlap_x < overlap_y then
            local direction_x = dx > 0 and 1 or -1
            if object_1.pushable_x and object_2.pushable_x then 
                object_1:collide_x(object_1.x + direction_x * overlap_x / 2)
                object_2:collide_x(object_2.x - direction_x * overlap_x / 2)
            end
            if object_1.pushable_x and not object_2.pushable_x then 
                object_1:collide_x(object_1.x + direction_x * overlap_x)
            end
            if not object_1.pushable_x and object_2.pushable_x then 
                object_2:collide_x(object_2.x - direction_x * overlap_x)
            end
        else
            local direction_y = dy > 0 and 1 or -1
            if object_1.pushable_y and object_2.pushable_y then 
                object_1:collide_y(object_1.y + direction_y * overlap_y / 2)
                object_2:collide_y(object_2.y - direction_y * overlap_y / 2)
            end
            if object_1.pushable_y and not object_2.pushable_y then 
                object_1:collide_y(object_1.y + direction_y * overlap_y)
            end
            if not object_1.pushable_y and object_2.pushable_y then 
                object_2:collide_y(object_2.y - direction_y * overlap_y)
            end
        end
    end
end

return Grid
