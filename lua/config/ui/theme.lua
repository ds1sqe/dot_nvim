local M = {}

M.list = {
  "halloween",
  "summer",
  "winter",
  "xmas",
  "none",
}
M.fix = nil

M.get_theme = function()
  if M.fix then
    return M.fix
  else
    math.randomseed(os.clock())
    M.fix = M.list[math.random(1, 5)]
    return M.fix
  end
end

M.drop_theme = function()
  local theme = M.get_theme()
  if theme == "halloween" then
    return "leaves"
  elseif theme == "winter" then
    return "snow"
  elseif theme == "xmas" then
    return "xmas"
  elseif theme == "summer" or theme == "none" then
    return "stars"
  end
end

function M.get(name)
  name = name or M.get_theme()
  local ret = {
    name = name,
    header = M.headers[name],
    statusline = M.statusline[name],
  }
  return ret
end

M.statusline = {
  halloween = "🧛👻👺🧟🎃",
  summer = "🌴🌊",
  winter = "🏂❄️ ⛷️",
  xmas = "🎅🎄🌟🎁",
}

M.headers = {
  none = [[
  TIME TO THINK        :PB@Bk:                       
                   ,jB@@B@B@B@BBL.                   
                7G@B@B@BMMMMMB@B@B@Nr                
            :kB@B@@@MMOMOMOMOMMMM@B@B@B1,            
        :5@B@B@B@BBMMOMOMOMOMOMOMM@@@B@B@BBu.        
     70@@@B@B@B@BXBBOMOMOMOMOMOMMBMPB@B@B@B@B@Nr     
   G@@@BJ iB@B@@  OBMOMOMOMOMOMOM@2  B@B@B. EB@B@S   
   @@BM@GJBU.  iSuB@OMOMOMOMOMOMM@OU1:  .kBLM@M@B@   
   B@MMB@B       7@BBMMOMOMOMOMOBB@:       B@BMM@B   
   @@@B@B         7@@@MMOMOMOMM@B@:         @@B@B@   
   @@OLB.          BNB@MMOMOMM@BEB          rBjM@B   
   @@  @           M  OBOMOMM@q  M          .@  @@   
   @@OvB           B:u@MMOMOMMBJiB          .BvM@B   
   @B@B@J         0@B@MMOMOMOMB@B@u         q@@@B@   
   B@MBB@v       G@@BMMMMMMMMMMMBB@5       F@BMM@B   
   @BBM@BPNi   LMEB@OMMMM@B@MMOMM@BZM7   rEqB@MBB@   
   B@@@BM  B@B@B  qBMOMB@B@B@BMOMBL  B@B@B  @B@B@M   
    J@@@@PB@B@B@B7G@OMBB : : @MMM@qLB@B@@@BqB@BBv    
       iGB@,i0@M@B@MMO@E  :  M@OMM@@@B@Pii@@N:       
              B@M@B@MMM@B@B@B@MMM@@@M@B              
              @B@B.i@MBB@B@B@@BM@::B@B@              
              B@@@ .B@B.:@B@ :B@B  @B@O              
                :0 r@B@  B@@ .@B@: P:                
                    vMB :@B@ :BO7                    
                        ,B@B                         
                                                     
]],
  winter = [[
   .-.                                                   \ /
  ( (                                |                  - * -
   '-`                              -+-                  / \
            \            o          _|_          \
            ))          }^{        /___\         ))
          .-#-----.     /|\     .---'-'---.    .-#-----.
     ___ /_________\   //|\\   /___________\  /_________\
    /___\ |[] _ []|    //|\\    | A /^\ A |    |[] _ []| _.O,_
....|"#"|.|  |*|  |...///|\\\...|   |"|   |....|  |*|  |..(^)....
]],
  xmas = [[
                                                        *                  
     *                                                          *          
                                  *                  *        .--.         
      \/ \/  \/  \/                                        ./   /=*        
        \/     \/      *            *                ...  (_____)          
         \ ^ ^/                                       \ \_((^o^))-.     *  
         (o)(O)--)--------\.                           \   (   ) \  \._.   
         |    |  ||================((~~~~~~~~~~~~~~~~~))|   ( )   |     \  
          \__/             ,|        \. * * * * * * ./  (~~~~~~~~~~~)    \ 
   *        ||^||\.____./|| |          \___________/     ~||~~~~|~'\____/ *
            || ||     || || A            ||    ||          ||    |   jurcy 
     *      <> <>     <> <>          (___||____||_____)   ((~~~~~|   *     
]],
  summer = [[
                               _                         
                           ,--.\`-. __                   
                         _,.`. \:/,"  `-._               
                     ,-*" _,.-;-*`-.+"*._ )              
                    ( ,."* ,-" / `.  \.  `.              
                   ,"   ,;"  ,"\../\  \:   \             
                  (   ,"/   / \.,' :   ))  /             
                   \  |/   / \.,'  /  // ,'              
                    \_)\ ,' \.,'  (  / )/                
                        `  \._,'   `"                    
                           \../                          
                           \../                          
                 ~        ~\../           ~~             
          ~~          ~~   \../   ~~   ~      ~~         
     ~~    ~   ~~  __...---\../-...__ ~~~     ~~         
       ~~~~  ~_,--'        \../      `--.__ ~~    ~~     
   ~~~  __,--'              `"             `--.__   ~~~  
~~  ,--'                                         `--.    
   '------......______             ______......------` ~~
 ~~~   ~    ~~      ~ `````---"""""  ~~   ~     ~~       
        ~~~~    ~~  ~~~~       ~~~~~~  ~ ~~   ~~ ~~~  ~  
     ~~   ~   ~~~     ~~~ ~         ~~       ~~   SSt    
              ~        ~~       ~~~       ~              
]],
  halloween = [[
                                              ,           ^'^  _     
                                              )               (_) ^'^
         _/\_                    .---------. ((        ^'^           
         (('>                    )`'`'`'`'`( ||                 ^'^  
    _    /^|                    /`'`'`'`'`'`\||           ^'^        
    =>--/__|m---               /`'`'`'`'`'`'`\|                      
         ^^           ,,,,,,, /`'`'`'`'`'`'`'`\      ,               
                     .-------.`|`````````````|`  .   )               
                    / .^. .^. \|  ,^^, ,^^,  |  / \ ((               
                   /  |_| |_|  \  |__| |__|  | /,-,\||               
        _         /_____________\ |")| |  |  |/ |_| \|               
       (")         |  __   __  |  '==' '=='  /_______\     _         
      (' ')        | /  \ /  \ |   _______   |,^, ,^,|    (")        
       \  \        | |--| |--| |  ((--.--))  ||_| |_||   (' ')       
     _  ^^^ _      | |__| |("| |  ||  |  ||  |,-, ,-,|   /  /        
   ,' ',  ,' ',    |           |  ||  |  ||  ||_| |_||   ^^^         
.,,|RIP|,.|RIP|,.,,'==========='==''=='==''=='=======',,....,,,,.,ldb
]],
}

return M
