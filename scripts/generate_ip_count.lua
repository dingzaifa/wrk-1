-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header

function delay()
   return 1000
end

wrk.method = "POST"
wrk.headers["Content-Type"] = "text/plain"

math.randomseed(tostring(os.time()):reverse():sub(1, 7))
local ip_num=2
local first_time=1

request = function()
   if(ip_num == 132) then
      ip_num = 2
   end
   edge_ip = "10.8.151." .. ip_num
   if(first_time == 1)then
      first_time = 0
   else
      ip_num = ip_num + 1
   end
   wrk.body = edge_ip .. " " .. os.time() .. "\n"
   for i=1,5000 do
      wrk.body = wrk.body .. "www.baidu.com/" .. i .. " " .. math.random(1,2000) .. "\n"
   end
   return wrk.format()
end
