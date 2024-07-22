data = io.open('emails.csv', "r"):read("*a")
map = { } -- [company name] = {email(s)}
inversemap = {} -- [email] = company name
io.output('debug.txt')
for lines in data:gmatch('[^\n]*') do
    names = lines:match('^[^\t]*')
    if not map[names] then
        map[names] = {}
    end
    io.write(names..'\n')
    lines:lower():gsub('[a-z0-9%.]+%@[a-z%.%-0-9]+[a-z]', function(email)
        if inversemap[email] then
            -- print('Duplicate email: ' .. email .. ' company name: ' .. names)
        else
            inversemap[email] = names
            table.insert(map[names], email)
        end
    end)
end
io.close()
io.output('output.txt')
for k, v in pairs(map) do
    io.write(k..'\n')
    for _, email in ipairs(v) do
        io.write('\t' .. email..'\n')
    end
end
io.close()