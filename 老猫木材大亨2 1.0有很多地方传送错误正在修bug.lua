local lp=game.Players.LocalPlayer
local mouse = lp:GetMouse()
local CurrentSlot = game.Players.LocalPlayer:WaitForChild("CurrentSaveSlot").Value
local ScriptLoadOrSave = false
local CurrentlySavingOrLoading = game.Players.LocalPlayer:WaitForChild("CurrentlySavingOrLoading")
local bai = {
  autoaxedupe=false,
  cuttreeselect="Generic",
  axedupepick=nil,
  autodupe=false,
  dxmz="",
  slot=-1,
  zlwjia="",
  zix=1,
  zlz=3,
  bringamount=1,
  bringtree=false,
  waterwalk=false,
  awaysday=false,
  awaysdnight=false,
  nofog=false,
  cswjiail=nil,
  itemset=nil,
  autocsdx=nil,
  autobuystop=false,
  autobuyamount=1,
  away = nil
}

local function notify(Title,Text,Duration) -- Sends Notification in the bottom right of the screen
  game.StarterGui:SetCore("SendNotification", {
    Title = Title;
    Text = Text;
    Icon = nil;
    Duration = Duration
  })
end
function Dupeaxe()


  lp.Character.Humanoid:UnequipTools()
  local oldpos = lp.Character.HumanoidRootPart.CFrame
  for i,v in pairs(game:service"Players".LocalPlayer.Backpack:GetChildren()) do
    game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v,"Drop tool")
  end

  game:service"Players".LocalPlayer.Character.Head:Destroy()
  wait(6)
  lp.Character.HumanoidRootPart.CFrame=oldpos
end
local Vehicle
function cartp(cframe)
  Vehicle = lp.Character.Humanoid.SeatPart.Parent
  spawn(function()
    for i = 1, 3 do
      task.wait()
      Vehicle:SetPrimaryPartCFrame(cframe)
    end
  end)
end
function ItemStackeraxe(ItemType, XAxis, ZAxis)
  local Player = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3.5, 0)
  local Items = {}

  for i, v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
    if v:FindFirstChild("Owner") and tostring(v.Owner.Value) ==bai.zlwjia
      then if (
        v:FindFirstChild "DraggableItem" and tostring(v.DraggableItem.Parent) == ItemType)
        then table
        .
        insert(Items, v)
      end
    end
  end
  local Count = 0
  for Y = 1, math.ceil(#Items / (XAxis * ZAxis)) do for X = 1, XAxis do for Z = 1, ZAxis do Count = Count
        + 1
        game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil,
        CFrame.new(X * Items[1].Main.Size.X, Y * Items[1].Main.Size.Y, Z * Items[1].Main.Size.Z) + Player
        ,
        game.Players.LocalPlayer, nil, Items[Count], true)
      end
    end
  end
end
function ItemStackerbox(ItemType, XAxis, ZAxis)
  local Player = game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 4, 0)
  local Items = {}

  for i, v in pairs(game:GetService("Workspace").PlayerModels:GetChildren()) do
    if v:FindFirstChild("Owner") and tostring(v.Owner.Value) ==bai.zlwjia
      then if (
        v:FindFirstChild("PurchasedBoxItemName") and tostring(v.PurchasedBoxItemName.Value) == ItemType)
        then table
        .
        insert(Items, v)
      end
    end
  end
  local Count = 0
  for Y = 1, math.ceil(#Items / (XAxis * ZAxis)) do for X = 1, XAxis do for Z = 1, ZAxis do Count = Count
        + 1
        game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil,
        CFrame.new(X * Items[1].Main.Size.X, Y * Items[1].Main.Size.Y, Z * Items[1].Main.Size.Z) + Player
        ,
        game.Players.LocalPlayer, nil, Items[Count], true)
      end
    end
  end
end
local function CheckIfSlotAvailable(Slot)
  for a,b in pairs(game.ReplicatedStorage.LoadSaveRequests.GetMetaData:InvokeServer(game.Players.LocalPlayer)) do
    if a == Slot then
      for c,d in pairs(b) do
        if c == "NumSaves" and d ~= 0 then
          return true
         else
          return false
        end
      end
    end
  end
end

local function CheckSlotNumber() --Checks if the slot number is right
  if bai.slot == "1" or bai.slot == "2" or bai.slot == "3" or bai.slot == "4" or bai.slot == "5" or bai.slot == "6" then
    local SlotNumber = tonumber(bai.slot)
    return SlotNumber
   else return false
  end
end




function toolsta(toolname)
  return require(game.ReplicatedStorage.Purchasables.Tools.AllTools[toolname].AxeClass).new()
end

local function table_foreach(table, callback)
  for i=1,#table do
    callback(i, table[i])
  end
end


local function tp(pos)
  if typeof(pos) == "CFrame" then
    lp.Character:SetPrimaryPartCFrame(pos)
   elseif typeof(pos) == "Vector3" then
    lp.Character:MoveTo(pos)
  end
end

function sellwood()
  for _, Log in pairs(workspace.LogModels:GetChildren()) do
    if Log.Name:sub(1, 6) == "Loose_" and Log:findFirstChild("Owner") then
      if Log.Owner.Value == game.Players.LocalPlayer then
        for i,v in pairs(Log:GetChildren()) do
          if v.Name=="WoodSection" then
            spawn(function()
              for i=1,100 do
                wait();
                game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(v.WoodSection)
                game.ReplicatedStorage.Interaction.ClientIsDragging:FireServer(v.WoodSection)
                v.CFrame=CFrame.new(Vector3.new(315, -0.296, 85.791))*CFrame.Angles(math.rad(90),0,0)
              end
            end)
          end
        end

      end
    end
  end
end



local function cutPart (tool,event, treeClass,axestr)
  game:GetService"ReplicatedStorage".Interaction.RemoteProxy:FireServer(event, {
    tool = tool,
    faceVector = Vector3.new(0, 0,-1),
    height = 0.3,
    sectionId = 1,
    hitPoints = axestr,
    cooldown = -14,
    cuttingClass = "Axe"
  })
end
local treeListener = function(treeClass, callback)
  local childAdded
  a= workspace.LogModels.ChildAdded:Connect(function(child)
    local owner = child:WaitForChild("Owner")
    if owner.Value == lp and child.TreeClass.Value == treeClass then
      a:Disconnect()
      callback(child)
    end
  end)
end


local getBiggestTree = function(treeClass)
  for _,v in next,workspace:children()do
    if tostring(v)=="TreeRegion"then
      for _,g in next,v:children()do
        if g:FindFirstChild("TreeClass")and tostring(g.TreeClass.Value)==treeClass and g:FindFirstChild("Owner")then
          if g.Owner.Value==nil or tostring(g.Owner.Value)==tostring(lp)then
            if #g:children() > 5 and g:FindFirstChild("WoodSection")then
              for h,j in next,g:children() do
                if j:FindFirstChild("ID")and j.ID.Value==1 and j.Size.Y>.5 then
                  return j;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  return false;
end
local function lowerBridge(value)

  if value=="Higher"then
    for _,v in pairs(game.workspace.Bridge.VerticalLiftBridge.Lift:GetChildren()) do
      v.CFrame = v.CFrame + Vector3.new(0, 26, 0)
    end

   elseif value=="Lower"then
    for _,v in pairs(game.workspace.Bridge.VerticalLiftBridge.Lift:GetChildren()) do
      v.CFrame = v.CFrame + Vector3.new(0, -26, 0)
    end
  end;
end
function modwood()
  local wood
  local Saw
  notify("自动加工", "请点击一颗树", 4)
  local ModTree = mouse.Button1Up:Connect(function()
    local obj = mouse.Target.Parent
    if not obj:FindFirstChild "RootCut" and obj.Parent.Name == "TreeRegion" then
      return notify("错误!", "这棵树还没有砍!", 3)
    end
    if obj:FindFirstChild "Owner" and obj.Owner.Value == lp and obj:FindFirstChild "WoodSection" then
      wood = obj
      notify("一键加工", "已选择树!", 3)
    end
    if obj.Name:find("Sawmill")then
      Saw=sawmill;
      notify("老猫","剧木机已选择",4)
     elseif obj.Parent.Name:find("Sawmill")or obj.Parent:FindFirstChild"BlockageAlert"then
      Saw=obj.Parent
      notify("老猫","剧木机已选择",4)
    end;
  end
  )
  repeat
    task.wait(.01)
  until wood and Saw ~= nil
  ModTree:Disconnect()
  ModTree = nil
  local SawC = Saw.Particles.CFrame + Vector3.new(0.7, 0)
  local cu,cw= 0,nil
  for p, I in next, wood:GetChildren() do
    if I.Name == "WoodSection" then
      if I.ID.Value > cu then
        cu = I.ID.Value
        cw=I
      end
    end
  end
  for p, I in next, wood:GetChildren() do
    if I.Name == "WoodSection" then

      for p, b in next, I.ChildIDs:GetChildren() do

        if b.Value ==cu then
          cv = I

        end
      end
    end
  end
  tp(cv.CFrame)
  wait()
  repeat wait(0.1)
    cv.CFrame = game.Workspace["Region_Volcano"].Lava.Lava.CFrame
  until cv:FindFirstChild("LavaFire");
  cv:FindFirstChild("LavaFire"):Destroy();
  tp(cw.CFrame)
  for i=1,20 do
    cw:MoveTo(Saw)
    cw.CFrame=SawC
  end
end
local function bringTree(treeClass)
  lp.Character.Humanoid:UnequipTools()
  local oldPos=lp.Character.HumanoidRootPart.CFrame;
  local tool
  local tool=0
  for i,v in pairs (lp.Backpack:GetChildren()) do
    if v.Name ~= "BlueprintTool"then
      tool=tool+1
    end
  end
  if tool==0 then
    return
    notify("老猫","你需要斧头",4)
  end


  for i,v in pairs (lp.Backpack:GetChildren()) do
    if v.Name ~= "BlueprintTool"then

      tool = v
    end
  end
  local toolname
  for i ,v in pairs (tool:GetChildren()) do
    if v.Name=="ToolName" then
      toolname=v.Value

    end
  end

  local axestr=toolsta(toolname)
  if axestr.SpecialTrees and axestr.SpecialTrees[treeClass] then
    for i, v in next, axestr.SpecialTrees[treeClass] do
      axestr[i] = v
    end
  end
  local tree = getBiggestTree(treeClass)

  if not tree then
    return notify("老猫","没有找到树",4)
  end




  local treeCut = false
  if treeClass=="LoveCave" and axestr.Damage<10000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end
  if treeClass=="Shine" and axestr.Damage<80000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end
  if treeClass=="Shine" and axestr.Damage<80000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end
  if treeClass=="Magma" and axestr.Damage<10000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end
  if treeClass=="Ice" and axestr.Damage<8000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end
  if treeClass== "Radioactive" and axestr.Damage<10000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end
  if treeClass== "Scale" and axestr.Damage<40000000 then
    return notify("老猫","你没有合适的斧头去砍这棵树") end

  workspace.Camera.CameraSubject = tree
  treeListener(treeClass, function(tree)
    tree.PrimaryPart = tree:FindFirstChild("WoodSection")
    treeCut = true
    wait()
    workspace.Camera.CameraSubject = lp.Character

  end)

  task.wait()


  repeat


    cutPart(tool,tree.Parent.CutEvent, treeClass,axestr.Damage)
    wait()
  until treeCut


end
local cashierIds = {}
local connection = game.ReplicatedStorage.NPCDialog.PromptChat.OnClientEvent:connect(function(bu, data)
  if cashierIds[data.Name] == nil then
    cashierIds[data.Name] = data.ID;
  end
end)

game.ReplicatedStorage.NPCDialog.SetChattingValue:InvokeServer(1)
spawn(function()
  repeat wait(0.5) until cashierIds["Thom"] ~= nil
  wait(3)
  connection:Disconnect()
  connection = nil
  game.ReplicatedStorage.NPCDialog.SetChattingValue:InvokeServer(0)

end)
local bt = false;

function finditem(BItem)
  local NameStore,Cashier,CID,StoreItems, Counter
  for _,w in pairs (s.ShopItems:GetChildren()) do
    if w.Name=="Bed1" or w.Name=="Seat_Couch" then
      NameStore = "Corey"
      Cashier = game.Workspace.Stores.FurnitureStore.Corey
      StoreItems =l
      Counter = game.Workspace.Stores.FurnitureStore.Counter.CFrame + Vector3.new(0, .4, 0)

     elseif w.Name=="Sawmill" or w.Name=="Sawmill2" then
      NameStore = "Thom"
      Cashier = game.Workspace.Stores.WoodRUs.Thom
      StoreItems =l
      Counter = game.Workspace.Stores.WoodRUs.Counter.CFrame + Vector3.new(0, .4, 0)

     elseif w.Name=="Trailer2" or w.Name=="UtilityTruck2" then
      NameStore = "Jenny"
      Cashier = game.Workspace.Stores.CarStore.Jenny
      StoreItems =l
      Counter = game.Workspace.Stores.CarStore.Counter.CFrame + Vector3.new(0, .4, 0)

     elseif w.Name=="CanOfWorms" or w.Name=="Dynamite" then
      NameStore = "Bob"
      Cashier = game.Workspace.Stores.ShackSho.Bob
      StoreItems =l
      Counter = game.Workspace.Stores.ShackShop.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="Painting1" or w.Name=="Painting2" then
      NameStore = "Timothy"
      Cashier = game.Workspace.Stores.FineArt.Timothy
      StoreItems =l
      Counter = game.Workspace.Stores.FineArt.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="GateXOR" or w.Name=="NeonWireOrange" then
      NameStore = "Lincoln"
      Cashier = game.Workspace.Stores.LogicStore.Lincoln
      StoreItems =l
      Counter = game.Workspace.Stores.LogicStore.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="BeachBall" or w.Name=="Cookie" then
      NameStore = "Guy"
      Cashier = game:GetService("Workspace").Stores.SeaSide.Guy
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.SeaSide.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="StrangeMan" or w.Name=="EndtimesChainsaw" then
      NameStore = "sneakypotato7"
      Cashier = game:GetService("Workspace").Stores.BlackMarket.sneakypotato7
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.BlackMarket.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="GoldGameCube" or w.Name=="GoldConveyorFunnel" then
      NameStore = "Todd"
      Cashier =game:GetService("Workspace").Stores.VIPSHOP.Todd
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.VIPSHOP.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="Playstation" or w.Name=="SawmillGift" then
      NameStore = "Mr.Bacon"
      Cashier =game:GetService("Workspace").Stores.MountainSide["Mr.Bacon"]
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.MountainSide.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="MegaConveyorFunnel" or w.Name=="GameCube" then
      NameStore = "Bloxyway"
      Cashier =game:GetService("Workspace").Stores.SamsStuff.Bloxyway
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.SamsStuff.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="StorageBox" or w.Name=="StorageBox" then
      NameStore = "Geck"
      Cashier =game:GetService("Workspace").Stores.BoatsStore.Geck
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.BoatsStore.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="FireRock" or w.Name=="PotFrost" then
      NameStore = "OGxOutcast"
      Cashier =game:GetService("Workspace").Stores.PlanterStore.OGxOutcast
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.PlanterStore.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="LumberCD" or w.Name=="UtilityVolt" then
      NameStore = "NotPlantomic56"
      Cashier =game:GetService("Workspace").Stores.TravelingTrader.NotPlantomic56
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.TravelingTrader.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="Eye1" or w.Name=="PumpkinClassic" then
      NameStore = "Sally"
      Cashier =game:GetService("Workspace").Stores.SallysSeasonal.Sally
      StoreItems =l
      Counter =game:GetService("Workspace").Stores.SallysSeasonal.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="LumberCDDab" or w.Name=="Lemon" then
      NameStore = "dab529"
      Cashier =game:GetService("Workspace").Stores.StoneRUs.dab529
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.StoneRUs.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="LeafCutters" or w.Name=="LeafFurnace" then
      NameStore = "William"
      Cashier =game:GetService("Workspace").Stores.AutumnCatalog.William
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.AutumnCatalog.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="AxeIce" or w.Name=="Cocoa" then
      NameStore = "Cold Guy"
      Cashier =game:GetService("Workspace").Stores.Igloo["Cold Guy"]
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.Igloo.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="Egg" or w.Name=="HappyBall" then
      NameStore = "Plantomic56"
      Cashier =game:GetService("Workspace").Stores.PlantomicsChoice.Plantomic56
      StoreItems =l
      Counter = game:GetService("Workspace").Stores.PlantomicsChoice.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="Wall2Round" or w.Name=="WritableSign" then
      NameStore = "Manachron"
      Cashier =game:GetService("Workspace").Stores.FineFinds.Manachron
      StoreItems =l
      Counter= game:GetService("Workspace").Stores.FineFinds.Counter.CFrame + Vector3.new(0, .4, 0)
     elseif w.Name=="SaplingCrate" or w.Name=="Planter2" then
      NameStore = "Billy"
      Cashier =game:GetService("Workspace").Stores.SaplingCart.Billy
      StoreItems =l
      Counter= game:GetService("Workspace").Stores.SaplingCart.Counter.CFrame + Vector3.new(0, .4, 0)




    end

  end




  if NameStore~=nil then
    return{NameStore,Cashier,cashierIds[Cashier.Name],Counter,StoreItems}
  end
end

function autobuyv2(o)


  local item=nil
  local ltem

  item=finditem(o)

  if item==nil then
    notify("老猫","没有找到商品或者没有刷新，请你等待",4)
    repeat
      item=finditem(o)
      wait()

    until item~=nil

  end

  ltem=item[5]


  game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil,item[4],lp, nil, ltem, true)



  game:GetService("ReplicatedStorage").NPCDialog.PlayerChatted:InvokeServer({["Character"] = item[2], ["Name"] =item[1], ["ID"] = tonumber(item[3])}, "ConfirmPurchase")



  return o
end

function autobuy(o, r)
  bai.autocsdx = game.Workspace.PlayerModels.ChildAdded:connect(function(v)

    game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil,bai.autobuyset,lp, nil, v, true)

  end)
  for e = 1, r do
    if bai.autobuystop==false then
      autobuyv2(o)
    end

  end
  spawn(function()
    wait(1)
    bai.autocsdx:Disconnect();
    bai.autocsdx=nil;
  end)
  return o, r
end
function tpitems(name)
  local plr = bai.cswjia
  local StealType = name

  for i,v in pairs(game.Workspace.PlayerModels:GetChildren()) do
    if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == plr then
      if StealType ~= "TreeClass" then
        if v:FindFirstChild("Type") and tostring(v.Type.Value) == StealType then
          if v.PrimaryPart then
            game:GetService("ReplicatedStorage").PlaceStructure.ClientPlacedStructure:FireServer(nil,bai.itemset,lp, nil, v, true)
          end
        end
       else

        if v:FindFirstChild("TreeClass") then

          spawn(function()
            for i=1 ,20 do
              game.ReplicatedStorage.Interaction.ClientRequestOwnership:FireServer(v.WoodSection)
              game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v.WoodSection)
              game:GetService("RunService").Stepped:wait();
            end
            v.WoodSection.CFrame= bai.itemset
          end)
          task.wait()



        end





      end
    end

  end
  notfy("老猫","完成",4)
end

function shuaxinlb(zji)
  bai.dropdown={}
  if zji==true then
    for p, I in next,game.Players:GetChildren() do
      table.insert(bai.dropdown, I.Name)
    end
   else
    for p, I in next, game.Players:GetChildren() do
      if I ~= lp then
        table.insert(bai.dropdown, I.Name)
      end
    end
  end
end
shuaxinlb(true)
repeat task.wait() until game:IsLoaded()
game.StarterGui:SetCore("SendNotification", {
  Title = "老猫",
  Text = "作者:11264iwqw/老猫/父yu7/注意此脚本只用于测试封号概不负责还有那些臭傻逼用不起付费的脚本就来用我这一个用吧我也没那么讨厌但是他妈让我加这加那我忙得过来吗有的玩就不错了，爱玩不玩不玩拉倒",
  Icon = "",
  Duration = 10,
})

local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
  __index = function(t, k)
    return game.GetService(game, k)
  end
})

local mouse = services.Players.LocalPlayer:GetMouse()

function Tween(obj, t, data)
  services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
  return true
end

function Ripple(obj)
  spawn(function()
    if obj.ClipsDescendants ~= true then
      obj.ClipsDescendants = true
    end
    local Ripple = Instance.new("ImageLabel")
    Ripple.Name = "Ripple"
    Ripple.Parent = obj
    Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Ripple.BackgroundTransparency = 1.000
    Ripple.ZIndex = 8
    Ripple.Image = "rbxassetid://16785029075"
    Ripple.ImageTransparency = 0.800
    Ripple.ScaleType = Enum.ScaleType.Fit
    Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Ripple.Position = UDim2.new((mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0, (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0)
    Tween(Ripple, {.3, 'Linear', 'InOut'}, {Position = UDim2.new(-5.5, 0, -5.5, 0), Size = UDim2.new(12, 0, 12, 0)})
    wait(0.15)
    Tween(Ripple, {.3, 'Linear', 'InOut'}, {ImageTransparency = 1})
    wait(.3)
    Ripple:Destroy()
  end)
end

local toggled = false

-- # Switch Tabs # --
local switchingTabs = false
function switchTab(new)
  if switchingTabs then return end
  local old = library.currentTab
  if old == nil then
    new[2].Visible = true
    library.currentTab = new
    services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
    services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
    return
  end

  if old[1] == new[1] then return end
  switchingTabs = true
  library.currentTab = new

  services.TweenService:Create(old[1], TweenInfo.new(0.1), {ImageTransparency = 0.2}):Play()
  services.TweenService:Create(new[1], TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
  services.TweenService:Create(old[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0.2}):Play()
  services.TweenService:Create(new[1].TabText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()

  old[2].Visible = false
  new[2].Visible = true

  task.wait(0.1)

  switchingTabs = false
end

-- # Drag, Stolen from Kiriot or Wally # --
function drag(frame, hold)
  if not hold then
    hold = frame
  end
  local dragging
  local dragInput
  local dragStart
  local startPos

  local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
  end

  hold.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
      dragging = true
      dragStart = input.Position
      startPos = frame.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          dragging = false
        end
      end)
    end
  end)

  frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
      dragInput = input
    end
  end)

  services.UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
      update(input)
    end
  end)
end

function library.new(library, name,theme)
  for _, v in next, services.CoreGui:GetChildren() do
    if v.Name == "qing" then
      v:Destroy()
    end
  end
  if theme == 'qing' then
    MainColor = Color3.fromRGB(10, 25, 255)
    Background = Color3.fromRGB(10, 25, 255)
    zyColor= Color3.fromRGB(10, 25, 255)
    beijingColor = Color3.fromRGB(10, 25, 255)
   else
    MainColor = Color3.fromRGB(0, 51, 179)
    Background = Color3.fromRGB(0, 51, 179)
    zyColor= Color3.fromRGB(0, 51, 179)
    beijingColor = Color3.fromRGB(0, 51, 179)
  end
  local dogent = Instance.new("ScreenGui")
  local OP = Instance.new("ImageLabel")
  local Main = Instance.new("Frame")
  local TabMain = Instance.new("Frame")
  local MainC = Instance.new("UICorner")
  local SB = Instance.new("Frame")
  local SBC = Instance.new("UICorner")
  local Side = Instance.new("Frame")
  local SideG = Instance.new("UIGradient")
  local TabBtns = Instance.new("ScrollingFrame")
  local TabBtnsL = Instance.new("UIListLayout")
  local ScriptTitle = Instance.new("TextLabel")
  local SBG = Instance.new("UIGradient")
  local Open = Instance.new("TextButton")
  local UIG=Instance.new("UIGradient")
  local DropShadowHolder = Instance.new("Frame")
  local DropShadow = Instance.new("ImageLabel")
  local UICornerMain = Instance.new("UICorner")
  local UIGradient=Instance.new("UIGradient")
  local UIGradientTitle=Instance.new("UIGradient")

  if syn and syn.protect_gui then syn.protect_gui(dogent) end

  dogent.Name = "qing"
  dogent.Parent = services.CoreGui

  function UiDestroy()
    dogent:Destroy()
  end

  function ToggleUILib()
    if not ToggleUI then
      dogent.Enabled = false
      ToggleUI = true
     else
      ToggleUI = false
      dogent.Enabled = true
    end
  end

  Main.Name = "Main"
  Main.Parent = dogent
  Main.AnchorPoint = Vector2.new(0.5, 0.5)
  Main.BackgroundColor3 = Background
  Main.BorderColor3 = MainColor
  Main.Position = UDim2.new(0.5, 0, 0.5, 0)
  Main.Size = UDim2.new(0, 572, 0, 353)
  Main.ZIndex = 1
  Main.Active = true
  Main.Draggable = true
  services.UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
      if Main.Visible == true then
        Main.Visible = false else
        Main.Visible = true
      end
    end
  end)
  drag(Main)

  UICornerMain.Parent = Main
  UICornerMain.CornerRadius = UDim.new(0,3)

  OP.Parent = Main
  OP.Image = "rbxassetid://16785029075"
  OP.Size = UDim2.new(0, 572, 0, 353)

  DropShadowHolder.Name = "DropShadowHolder"
  DropShadowHolder.Parent = Main
  DropShadowHolder.BackgroundTransparency = 1.000
  DropShadowHolder.BorderSizePixel = 0
  DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
  DropShadowHolder.BorderColor3 = Color3.fromRGB(255,255,255)
  DropShadowHolder.ZIndex = 0

  DropShadow.Name = "DropShadow"
  DropShadow.Parent = DropShadowHolder
  DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
  DropShadow.BackgroundTransparency = 1.000
  DropShadow.BorderSizePixel = 0
  DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
  DropShadow.Size = UDim2.new(1, 43, 1, 43)
  DropShadow.ZIndex = 0
  DropShadow.Image = "rbxassetid://6015897843"
  DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
  DropShadow.ImageTransparency = 0.500
  DropShadow.ScaleType = Enum.ScaleType.Slice
  DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)


  UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(139, 0, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(255, 127, 0)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 0))}
  UIGradient.Parent = DropShadow

  local TweenService = game:GetService("TweenService")
  local tweeninfo = TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1)
  local tween = TweenService:Create(UIGradient, tweeninfo, {Rotation = 360})
  tween:Play()

  function toggleui()
    toggled = not toggled
    spawn(function()
      if toggled then wait(0.3) end
    end)
    Tween(Main, {0.3, 'Sine', 'InOut'}, {
      Size = UDim2.new(0, 609, 0, (toggled and 505 or 0))
    })
  end

  TabMain.Name = "TabMain"
  TabMain.Parent = Main
  TabMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  TabMain.BackgroundTransparency = 1.000
  TabMain.Position = UDim2.new(0.217000037, 0, 0, 3)
  TabMain.Size = UDim2.new(0, 448, 0, 353)

  MainC.CornerRadius = UDim.new(0, 5.5)
  MainC.Name = "MainC"
  MainC.Parent = Frame

  SB.Name = "SB"
  SB.Parent = Main
  SB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  SB.BorderColor3 = MainColor
  SB.Size = UDim2.new(0, 8, 0, 353)

  SBC.CornerRadius = UDim.new(0, 6)
  SBC.Name = "SBC"
  SBC.Parent = SB

  Side.Name = "Side"
  Side.Parent = SB
  Side.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  Side.BorderColor3 = Color3.fromRGB(255, 255, 255)
  Side.BorderSizePixel = 0
  Side.ClipsDescendants = true
  Side.Position = UDim2.new(1, 0, 0, 0)
  Side.Size = UDim2.new(0, 110, 0, 353)

  SideG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
  SideG.Rotation = 90
  SideG.Name = "SideG"
  SideG.Parent = Side

  TabBtns.Name = "TabBtns"
  TabBtns.Parent = Side
  TabBtns.Active = true
  TabBtns.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  TabBtns.BackgroundTransparency = 1.000
  TabBtns.BorderSizePixel = 0
  TabBtns.Position = UDim2.new(0, 0, 0.0973535776, 0)
  TabBtns.Size = UDim2.new(0, 110, 0, 318)
  TabBtns.CanvasSize = UDim2.new(0, 0, 1, 0)
  TabBtns.ScrollBarThickness = 0

  TabBtnsL.Name = "TabBtnsL"
  TabBtnsL.Parent = TabBtns
  TabBtnsL.SortOrder = Enum.SortOrder.LayoutOrder
  TabBtnsL.Padding = UDim.new(0, 12)

  ScriptTitle.Name = "ScriptTitle"
  ScriptTitle.Parent = Side
  ScriptTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  ScriptTitle.BackgroundTransparency = 1.000
  ScriptTitle.Position = UDim2.new(0, 0, 0.00953488424, 0)
  ScriptTitle.Size = UDim2.new(0, 102, 0, 20)
  ScriptTitle.Font = Enum.Font.GothamSemibold
  ScriptTitle.Text = name
  ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
  ScriptTitle.TextSize = 14.000
  ScriptTitle.TextScaled = true
  ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left

  UIGradientTitle.Parent = ScriptTitle

  local function NPLHKB_fake_script()
    local script = Instance.new('LocalScript', ScriptTitle)

    local button = script.Parent
    local gradient = button.UIGradient
    local ts = game:GetService("TweenService")
    local ti = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local offset = {Offset = Vector2.new(1, 0)}
    local create = ts:Create(gradient, ti, offset)
    local startingPos = Vector2.new(-1, 0)
    local list = {}
    local s, kpt = ColorSequence.new, ColorSequenceKeypoint.new
    local counter = 0
    local status = "down"
    gradient.Offset = startingPos
    local function rainbowColors()
      local sat, val = 255, 255
      for i = 1, 10 do
        local hue = i * 17
        table.insert(list, Color3.fromHSV(hue / 255, sat / 255, val / 255))
      end
    end
    rainbowColors()
    gradient.Color = s({
      kpt(0, list[#list]),
      kpt(0.5, list[#list - 1]),
      kpt(1, list[#list - 2])
    })
    counter = #list
    local function animate()
      create:Play()
      create.Completed:Wait()
      gradient.Offset = startingPos
      gradient.Rotation = 180
      if counter == #list - 1 and status == "down" then
        gradient.Color = s({
          kpt(0, gradient.Color.Keypoints[1].Value),
          kpt(0.5, list[#list]),
          kpt(1, list[1])
        })
        counter = 1
        status = "up"
       elseif counter == #list and status == "down" then
        gradient.Color = s({
          kpt(0, gradient.Color.Keypoints[1].Value),
          kpt(0.5, list[1]),
          kpt(1, list[2])
        })
        counter = 2
        status = "up"
       elseif counter <= #list - 2 and status == "down" then
        gradient.Color = s({
          kpt(0, gradient.Color.Keypoints[1].Value),
          kpt(0.5, list[counter + 1]),
          kpt(1, list[counter + 2])
        })
        counter = counter + 2
        status = "up"
      end
      create:Play()
      create.Completed:Wait()
      gradient.Offset = startingPos
      gradient.Rotation = 0
      if counter == #list - 1 and status == "up" then
        gradient.Color = s({

          kpt(0, list[1]),
          kpt(0.5, list[#list]),
          kpt(1, gradient.Color.Keypoints[3].Value)
        })
        counter = 1
        status = "down"
       elseif counter == #list and status == "up" then
        gradient.Color = s({
          kpt(0, list[2]),
          kpt(0.5, list[1]),
          kpt(1, gradient.Color.Keypoints[3].Value)
        })
        counter = 2
        status = "down"
       elseif counter <= #list - 2 and status == "up" then
        gradient.Color = s({
          kpt(0, list[counter + 2]),
          kpt(0.5, list[counter + 1]),
          kpt(1, gradient.Color.Keypoints[3].Value)
        })
        counter = counter + 2
        status = "down"
      end
      animate()
    end
    animate()

  end
  coroutine.wrap(NPLHKB_fake_script)()

  SBG.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, zyColor), ColorSequenceKeypoint.new(1.00, zyColor)}
  SBG.Rotation = 90
  SBG.Name = "SBG"
  SBG.Parent = SB

  TabBtnsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabBtns.CanvasSize = UDim2.new(0, 0, 0, TabBtnsL.AbsoluteContentSize.Y + 18)
  end)
  Open.Name = "Open"
  Open.Parent = dogent
  Open.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
  Open.Position = UDim2.new(0.00829315186, 0, 0.31107837, 0)
  Open.Size = UDim2.new(0, 61, 0, 32)
  Open.Font = Enum.Font.SourceSans
  Open.Text = "隐藏/打开"
  Open.TextColor3 = Color3.fromRGB(255, 255, 255)
  Open.TextSize = 14.000
  Open.Active = true
  Open.Draggable = true
  Open.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
  end)
  UIG.Parent = Open
  local window = {}
  function window.Tab(window, name, icon)
    local Tab = Instance.new("ScrollingFrame")
    local TabIco = Instance.new("ImageLabel")
    local TabText = Instance.new("TextLabel")
    local TabBtn = Instance.new("TextButton")
    local TabL = Instance.new("UIListLayout")

    Tab.Name = "Tab"
    Tab.Parent = TabMain
    Tab.Active = true
    Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab.BackgroundTransparency = 1.000
    Tab.Size = UDim2.new(1, 0, 1, 0)
    Tab.ScrollBarThickness = 2
    Tab.Visible = false

    TabIco.Name = "TabIco"
    TabIco.Parent = TabBtns
    TabIco.BackgroundTransparency = 1.000
    TabIco.BorderSizePixel = 0
    TabIco.Size = UDim2.new(0, 24, 0, 24)
    TabIco.Image = ("rbxassetid://%s"):format((icon or 4370341699))
    TabIco.ImageTransparency = 0.2

    TabText.Name = "TabText"
    TabText.Parent = TabIco
    TabText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabText.BackgroundTransparency = 1.000
    TabText.Position = UDim2.new(1.41666663, 0, 0, 0)
    TabText.Size = UDim2.new(0, 76, 0, 24)
    TabText.Font = Enum.Font.GothamSemibold
    TabText.Text = name
    TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabText.TextSize = 14.000
    TabText.TextXAlignment = Enum.TextXAlignment.Left
    TabText.TextTransparency = 0.2

    TabBtn.Name = "TabBtn"
    TabBtn.Parent = TabIco
    TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.BackgroundTransparency = 1.000
    TabBtn.BorderSizePixel = 0
    TabBtn.Size = UDim2.new(0, 110, 0, 24)
    TabBtn.AutoButtonColor = false
    TabBtn.Font = Enum.Font.SourceSans
    TabBtn.Text = ""
    TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabBtn.TextSize = 14.000

    TabL.Name = "TabL"
    TabL.Parent = Tab
    TabL.SortOrder = Enum.SortOrder.LayoutOrder
    TabL.Padding = UDim.new(0, 4)

    TabBtn.MouseButton1Click:Connect(function()
      spawn(function()
        Ripple(TabBtn)
      end)
      switchTab({TabIco, Tab})
    end)

    if library.currentTab == nil then switchTab({TabIco, Tab}) end

    TabL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
      Tab.CanvasSize = UDim2.new(0, 0, 0, TabL.AbsoluteContentSize.Y + 8)
    end)

    local tab = {}
    function tab.section(tab, name, TabVal)
      local Section = Instance.new("Frame")
      local SectionC = Instance.new("UICorner")
      local SectionText = Instance.new("TextLabel")
      local SectionOpen = Instance.new("ImageLabel")
      local SectionOpened = Instance.new("ImageLabel")
      local SectionToggle = Instance.new("ImageButton")
      local Objs = Instance.new("Frame")
      local ObjsL = Instance.new("UIListLayout")

      Section.Name = "Section"
      Section.Parent = Tab
      Section.BackgroundColor3 = Color3.fromRGB(102, 190, 193)
      Section.BackgroundTransparency = 1.000
      Section.BorderSizePixel = 0
      Section.ClipsDescendants = true
      Section.Size = UDim2.new(0.981000006, 0, 0, 36)

      SectionC.CornerRadius = UDim.new(0, 6)
      SectionC.Name = "SectionC"
      SectionC.Parent = Section

      SectionText.Name = "SectionText"
      SectionText.Parent = Section
      SectionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      SectionText.BackgroundTransparency = 1.000
      SectionText.Position = UDim2.new(0.0887396261, 0, 0, 0)
      SectionText.Size = UDim2.new(0, 401, 0, 36)
      SectionText.Font = Enum.Font.GothamSemibold
      SectionText.Text = name
      SectionText.TextColor3 = Color3.fromRGB(255, 255, 255)
      SectionText.TextSize = 16.000
      SectionText.TextXAlignment = Enum.TextXAlignment.Left

      SectionOpen.Name = "SectionOpen"
      SectionOpen.Parent = SectionText
      SectionOpen.BackgroundTransparency = 1
      SectionOpen.BorderSizePixel = 0
      SectionOpen.Position = UDim2.new(0, -33, 0, 5)
      SectionOpen.Size = UDim2.new(0, 26, 0, 26)
      SectionOpen.Image = "http://www.roblox.com/asset/?id=6031302934"

      SectionOpened.Name = "SectionOpened"
      SectionOpened.Parent = SectionOpen
      SectionOpened.BackgroundTransparency = 1.000
      SectionOpened.BorderSizePixel = 0
      SectionOpened.Size = UDim2.new(0, 26, 0, 26)
      SectionOpened.Image = "http://www.roblox.com/asset/?id=6031302932"
      SectionOpened.ImageTransparency = 1.000

      SectionToggle.Name = "SectionToggle"
      SectionToggle.Parent = SectionOpen
      SectionToggle.BackgroundTransparency = 1
      SectionToggle.BorderSizePixel = 0
      SectionToggle.Size = UDim2.new(0, 26, 0, 26)

      Objs.Name = "Objs"
      Objs.Parent = Section
      Objs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Objs.BackgroundTransparency = 1
      Objs.BorderSizePixel = 0
      Objs.Position = UDim2.new(0, 6, 0, 36)
      Objs.Size = UDim2.new(0.986347735, 0, 0, 0)

      ObjsL.Name = "ObjsL"
      ObjsL.Parent = Objs
      ObjsL.SortOrder = Enum.SortOrder.LayoutOrder
      ObjsL.Padding = UDim.new(0, 8)

      local open = TabVal
      if TabVal ~= false then
        Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
        SectionOpened.ImageTransparency = (open and 0 or 1)
        SectionOpen.ImageTransparency = (open and 1 or 0)
      end

      SectionToggle.MouseButton1Click:Connect(function()
        open = not open
        Section.Size = UDim2.new(0.981000006, 0, 0, open and 36 + ObjsL.AbsoluteContentSize.Y + 8 or 36)
        SectionOpened.ImageTransparency = (open and 0 or 1)
        SectionOpen.ImageTransparency = (open and 1 or 0)
      end)

      ObjsL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        if not open then return end
        Section.Size = UDim2.new(0.981000006, 0, 0, 36 + ObjsL.AbsoluteContentSize.Y + 8)
      end)

      local section = {}
      function section.Button(section, text, callback)
        local callback = callback or function() end

        local BtnModule = Instance.new("Frame")
        local Btn = Instance.new("TextButton")
        local BtnC = Instance.new("UICorner")

        BtnModule.Name = "BtnModule"
        BtnModule.Parent = Objs
        BtnModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BtnModule.BackgroundTransparency = 1.000
        BtnModule.BorderSizePixel = 0
        BtnModule.Position = UDim2.new(0, 0, 0, 0)
        BtnModule.Size = UDim2.new(0, 428, 0, 38)

        Btn.Name = "Btn"
        Btn.Parent = BtnModule
        Btn.BackgroundColor3 = zyColor
        Btn.BorderSizePixel = 0
        Btn.Size = UDim2.new(0, 428, 0, 38)
        Btn.AutoButtonColor = false
        Btn.Font = Enum.Font.GothamSemibold
        Btn.Text = "   " .. text
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.TextSize = 16.000
        Btn.TextXAlignment = Enum.TextXAlignment.Left

        BtnC.CornerRadius = UDim.new(0, 6)
        BtnC.Name = "BtnC"
        BtnC.Parent = Btn

        Btn.MouseButton1Click:Connect(function()
          spawn(function()
            Ripple(Btn)
          end)
          spawn(callback)
        end)
      end

      function section:Label(text)
        local LabelModule = Instance.new("Frame")
        local TextLabel = Instance.new("TextLabel")
        local LabelC = Instance.new("UICorner")

        LabelModule.Name = "LabelModule"
        LabelModule.Parent = Objs
        LabelModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelModule.BackgroundTransparency = 1.000
        LabelModule.BorderSizePixel = 0
        LabelModule.Position = UDim2.new(0, 0, NAN, 0)
        LabelModule.Size = UDim2.new(0, 428, 0, 19)

        TextLabel.Parent = LabelModule
        TextLabel.BackgroundColor3 = zyColor
        TextLabel.Size = UDim2.new(0, 428, 0, 22)
        TextLabel.Font = Enum.Font.GothamSemibold
        TextLabel.Text = text
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 14.000

        LabelC.CornerRadius = UDim.new(0, 6)
        LabelC.Name = "LabelC"
        LabelC.Parent = TextLabel
        return TextLabel
      end

      function section.Toggle(section, text, flag, enabled, callback)
        local callback = callback or function() end
        local enabled = enabled or false
        assert(text, "No text provided")
        assert(flag, "No flag provided")

        library.flags[flag] = enabled

        local ToggleModule = Instance.new("Frame")
        local ToggleBtn = Instance.new("TextButton")
        local ToggleBtnC = Instance.new("UICorner")
        local ToggleDisable = Instance.new("Frame")
        local ToggleSwitch = Instance.new("Frame")
        local ToggleSwitchC = Instance.new("UICorner")
        local ToggleDisableC = Instance.new("UICorner")

        ToggleModule.Name = "ToggleModule"
        ToggleModule.Parent = Objs
        ToggleModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleModule.BackgroundTransparency = 1.000
        ToggleModule.BorderSizePixel = 0
        ToggleModule.Position = UDim2.new(0, 0, 0, 0)
        ToggleModule.Size = UDim2.new(0, 428, 0, 38)

        ToggleBtn.Name = "ToggleBtn"
        ToggleBtn.Parent = ToggleModule
        ToggleBtn.BackgroundColor3 = zyColor
        ToggleBtn.BorderSizePixel = 0
        ToggleBtn.Size = UDim2.new(0, 428, 0, 38)
        ToggleBtn.AutoButtonColor = false
        ToggleBtn.Font = Enum.Font.GothamSemibold
        ToggleBtn.Text = "   " .. text
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.TextSize = 16.000
        ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left

        ToggleBtnC.CornerRadius = UDim.new(0, 6)
        ToggleBtnC.Name = "ToggleBtnC"
        ToggleBtnC.Parent = ToggleBtn

        ToggleDisable.Name = "ToggleDisable"
        ToggleDisable.Parent = ToggleBtn
        ToggleDisable.BackgroundColor3 = Background
        ToggleDisable.BorderSizePixel = 0
        ToggleDisable.Position = UDim2.new(0.901869178, 0, 0.208881587, 0)
        ToggleDisable.Size = UDim2.new(0, 36, 0, 22)

        ToggleSwitch.Name = "ToggleSwitch"
        ToggleSwitch.Parent = ToggleDisable
        ToggleSwitch.BackgroundColor3 = beijingColor
        ToggleSwitch.Size = UDim2.new(0, 24, 0, 22)

        ToggleSwitchC.CornerRadius = UDim.new(0, 6)
        ToggleSwitchC.Name = "ToggleSwitchC"
        ToggleSwitchC.Parent = ToggleSwitch

        ToggleDisableC.CornerRadius = UDim.new(0, 6)
        ToggleDisableC.Name = "ToggleDisableC"
        ToggleDisableC.Parent = ToggleDisable

        local funcs = {
          SetState = function(self, state)
            if state == nil then state = not library.flags[flag] end
            if library.flags[flag] == state then return end
            services.TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {Position = UDim2.new(0, (state and ToggleSwitch.Size.X.Offset / 2 or 0), 0, 0), BackgroundColor3 = (state and Color3.fromRGB(255, 255, 255) or beijingColor)}):Play()
            library.flags[flag] = state
            callback(state)
          end,
          Module = ToggleModule
        }

        if enabled ~= false then
          funcs:SetState(flag,true)
        end

        ToggleBtn.MouseButton1Click:Connect(function()
          funcs:SetState()
        end)
        return funcs
      end

      function section.Keybind(section, text, default, callback)
        local callback = callback or function() end
        assert(text, "No text provided")
        assert(default, "No default key provided")

        local default = (typeof(default) == "string" and Enum.KeyCode[default] or default)
        local banned = {
          Return = true;
          Space = true;
          Tab = true;
          Backquote = true;
          CapsLock = true;
          Escape = true;
          Unknown = true;
        }
        local shortNames = {
          RightControl = 'Right Ctrl',
          LeftControl = 'Left Ctrl',
          LeftShift = 'Left Shift',
          RightShift = 'Right Shift',
          Semicolon = ";",
          Quote = '"',
          LeftBracket = '[',
          RightBracket = ']',
          Equals = '=',
          Minus = '-',
          RightAlt = 'Right Alt',
          LeftAlt = 'Left Alt'
        }

        local bindKey = default
        local keyTxt = (default and (shortNames[default.Name] or default.Name) or "None")

        local KeybindModule = Instance.new("Frame")
        local KeybindBtn = Instance.new("TextButton")
        local KeybindBtnC = Instance.new("UICorner")
        local KeybindValue = Instance.new("TextButton")
        local KeybindValueC = Instance.new("UICorner")
        local KeybindL = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")

        KeybindModule.Name = "KeybindModule"
        KeybindModule.Parent = Objs
        KeybindModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        KeybindModule.BackgroundTransparency = 1.000
        KeybindModule.BorderSizePixel = 0
        KeybindModule.Position = UDim2.new(0, 0, 0, 0)
        KeybindModule.Size = UDim2.new(0, 428, 0, 38)

        KeybindBtn.Name = "KeybindBtn"
        KeybindBtn.Parent = KeybindModule
        KeybindBtn.BackgroundColor3 = zyColor
        KeybindBtn.BorderSizePixel = 0
        KeybindBtn.Size = UDim2.new(0, 428, 0, 38)
        KeybindBtn.AutoButtonColor = false
        KeybindBtn.Font = Enum.Font.GothamSemibold
        KeybindBtn.Text = "   " .. text
        KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeybindBtn.TextSize = 16.000
        KeybindBtn.TextXAlignment = Enum.TextXAlignment.Left

        KeybindBtnC.CornerRadius = UDim.new(0, 6)
        KeybindBtnC.Name = "KeybindBtnC"
        KeybindBtnC.Parent = KeybindBtn

        KeybindValue.Name = "KeybindValue"
        KeybindValue.Parent = KeybindBtn
        KeybindValue.BackgroundColor3 = Background
        KeybindValue.BorderSizePixel = 0
        KeybindValue.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
        KeybindValue.Size = UDim2.new(0, 100, 0, 28)
        KeybindValue.AutoButtonColor = false
        KeybindValue.Font = Enum.Font.Gotham
        KeybindValue.Text = keyTxt
        KeybindValue.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeybindValue.TextSize = 14.000

        KeybindValueC.CornerRadius = UDim.new(0, 6)
        KeybindValueC.Name = "KeybindValueC"
        KeybindValueC.Parent = KeybindValue

        KeybindL.Name = "KeybindL"
        KeybindL.Parent = KeybindBtn
        KeybindL.HorizontalAlignment = Enum.HorizontalAlignment.Right
        KeybindL.SortOrder = Enum.SortOrder.LayoutOrder
        KeybindL.VerticalAlignment = Enum.VerticalAlignment.Center

        UIPadding.Parent = KeybindBtn
        UIPadding.PaddingRight = UDim.new(0, 6)

        services.UserInputService.InputBegan:Connect(function(inp, gpe)
          if gpe then return end
          if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
          if inp.KeyCode ~= bindKey then return end
          callback(bindKey.Name)
        end)

        KeybindValue.MouseButton1Click:Connect(function()
          KeybindValue.Text = "..."
          wait()
          local key, uwu = services.UserInputService.InputEnded:Wait()
          local keyName = tostring(key.KeyCode.Name)
          if key.UserInputType ~= Enum.UserInputType.Keyboard then
            KeybindValue.Text = keyTxt
            return
          end
          if banned[keyName] then
            KeybindValue.Text = keyTxt
            return
          end
          wait()
          bindKey = Enum.KeyCode[keyName]
          KeybindValue.Text = shortNames[keyName] or keyName
        end)

        KeybindValue:GetPropertyChangedSignal("TextBounds"):Connect(function()
          KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
        end)
        KeybindValue.Size = UDim2.new(0, KeybindValue.TextBounds.X + 30, 0, 28)
      end

      function section.Textbox(section, text, flag, default, callback)
        local callback = callback or function() end
        assert(text, "No text provided")
        assert(flag, "No flag provided")
        assert(default, "No default text provided")

        library.flags[flag] = default

        local TextboxModule = Instance.new("Frame")
        local TextboxBack = Instance.new("TextButton")
        local TextboxBackC = Instance.new("UICorner")
        local BoxBG = Instance.new("TextButton")
        local BoxBGC = Instance.new("UICorner")
        local TextBox = Instance.new("TextBox")
        local TextboxBackL = Instance.new("UIListLayout")
        local TextboxBackP = Instance.new("UIPadding")

        TextboxModule.Name = "TextboxModule"
        TextboxModule.Parent = Objs
        TextboxModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextboxModule.BackgroundTransparency = 1.000
        TextboxModule.BorderSizePixel = 0
        TextboxModule.Position = UDim2.new(0, 0, 0, 0)
        TextboxModule.Size = UDim2.new(0, 428, 0, 38)

        TextboxBack.Name = "TextboxBack"
        TextboxBack.Parent = TextboxModule
        TextboxBack.BackgroundColor3 = zyColor
        TextboxBack.BorderSizePixel = 0
        TextboxBack.Size = UDim2.new(0, 428, 0, 38)
        TextboxBack.AutoButtonColor = false
        TextboxBack.Font = Enum.Font.GothamSemibold
        TextboxBack.Text = "   " .. text
        TextboxBack.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextboxBack.TextSize = 16.000
        TextboxBack.TextXAlignment = Enum.TextXAlignment.Left

        TextboxBackC.CornerRadius = UDim.new(0, 6)
        TextboxBackC.Name = "TextboxBackC"
        TextboxBackC.Parent = TextboxBack

        BoxBG.Name = "BoxBG"
        BoxBG.Parent = TextboxBack
        BoxBG.BackgroundColor3 = Background
        BoxBG.BorderSizePixel = 0
        BoxBG.Position = UDim2.new(0.763033211, 0, 0.289473683, 0)
        BoxBG.Size = UDim2.new(0, 100, 0, 28)
        BoxBG.AutoButtonColor = false
        BoxBG.Font = Enum.Font.Gotham
        BoxBG.Text = ""
        BoxBG.TextColor3 = Color3.fromRGB(255, 255, 255)
        BoxBG.TextSize = 14.000

        BoxBGC.CornerRadius = UDim.new(0, 6)
        BoxBGC.Name = "BoxBGC"
        BoxBGC.Parent = BoxBG

        TextBox.Parent = BoxBG
        TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.BackgroundTransparency = 1.000
        TextBox.BorderSizePixel = 0
        TextBox.Size = UDim2.new(1, 0, 1, 0)
        TextBox.Font = Enum.Font.Gotham
        TextBox.Text = default
        TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextBox.TextSize = 14.000

        TextboxBackL.Name = "TextboxBackL"
        TextboxBackL.Parent = TextboxBack
        TextboxBackL.HorizontalAlignment = Enum.HorizontalAlignment.Right
        TextboxBackL.SortOrder = Enum.SortOrder.LayoutOrder
        TextboxBackL.VerticalAlignment = Enum.VerticalAlignment.Center

        TextboxBackP.Name = "TextboxBackP"
        TextboxBackP.Parent = TextboxBack
        TextboxBackP.PaddingRight = UDim.new(0, 6)

        TextBox.FocusLost:Connect(function()
          if TextBox.Text == "" then
            TextBox.Text = default
          end
          library.flags[flag] = TextBox.Text
          callback(TextBox.Text)
        end)

        TextBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
          BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
        end)
        BoxBG.Size = UDim2.new(0, TextBox.TextBounds.X + 30, 0, 28)
      end

      function section.Slider(section, text, flag, default, min, max, precise, callback)
        local callback = callback or function() end
        local min = min or 1
        local max = max or 10
        local default = default or min
        local precise = precise or false

        library.flags[flag] = default

        assert(text, "No text provided")
        assert(flag, "No flag provided")
        assert(default, "No default value provided")

        local SliderModule = Instance.new("Frame")
        local SliderBack = Instance.new("TextButton")
        local SliderBackC = Instance.new("UICorner")
        local SliderBar = Instance.new("Frame")
        local SliderBarC = Instance.new("UICorner")
        local SliderPart = Instance.new("Frame")
        local SliderPartC = Instance.new("UICorner")
        local SliderValBG = Instance.new("TextButton")
        local SliderValBGC = Instance.new("UICorner")
        local SliderValue = Instance.new("TextBox")
        local MinSlider = Instance.new("TextButton")
        local AddSlider = Instance.new("TextButton")

        SliderModule.Name = "SliderModule"
        SliderModule.Parent = Objs
        SliderModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderModule.BackgroundTransparency = 1.000
        SliderModule.BorderSizePixel = 0
        SliderModule.Position = UDim2.new(0, 0, 0, 0)
        SliderModule.Size = UDim2.new(0, 428, 0, 38)

        SliderBack.Name = "SliderBack"
        SliderBack.Parent = SliderModule
        SliderBack.BackgroundColor3 = zyColor
        SliderBack.BorderSizePixel = 0
        SliderBack.Size = UDim2.new(0, 428, 0, 38)
        SliderBack.AutoButtonColor = false
        SliderBack.Font = Enum.Font.GothamSemibold
        SliderBack.Text = "   " .. text
        SliderBack.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderBack.TextSize = 16.000
        SliderBack.TextXAlignment = Enum.TextXAlignment.Left

        SliderBackC.CornerRadius = UDim.new(0, 6)
        SliderBackC.Name = "SliderBackC"
        SliderBackC.Parent = SliderBack

        SliderBar.Name = "SliderBar"
        SliderBar.Parent = SliderBack
        SliderBar.AnchorPoint = Vector2.new(0, 0.5)
        SliderBar.BackgroundColor3 = Background
        SliderBar.BorderSizePixel = 0
        SliderBar.Position = UDim2.new(0.369000018, 40, 0.5, 0)
        SliderBar.Size = UDim2.new(0, 140, 0, 12)

        SliderBarC.CornerRadius = UDim.new(0, 4)
        SliderBarC.Name = "SliderBarC"
        SliderBarC.Parent = SliderBar

        SliderPart.Name = "SliderPart"
        SliderPart.Parent = SliderBar
        SliderPart.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderPart.BorderSizePixel = 0
        SliderPart.Size = UDim2.new(0, 54, 0, 13)

        SliderPartC.CornerRadius = UDim.new(0, 4)
        SliderPartC.Name = "SliderPartC"
        SliderPartC.Parent = SliderPart

        SliderValBG.Name = "SliderValBG"
        SliderValBG.Parent = SliderBack
        SliderValBG.BackgroundColor3 = Background
        SliderValBG.BorderSizePixel = 0
        SliderValBG.Position = UDim2.new(0.883177578, 0, 0.131578952, 0)
        SliderValBG.Size = UDim2.new(0, 44, 0, 28)
        SliderValBG.AutoButtonColor = false
        SliderValBG.Font = Enum.Font.Gotham
        SliderValBG.Text = ""
        SliderValBG.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderValBG.TextSize = 14.000

        SliderValBGC.CornerRadius = UDim.new(0, 6)
        SliderValBGC.Name = "SliderValBGC"
        SliderValBGC.Parent = SliderValBG

        SliderValue.Name = "SliderValue"
        SliderValue.Parent = SliderValBG
        SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderValue.BackgroundTransparency = 1.000
        SliderValue.BorderSizePixel = 0
        SliderValue.Size = UDim2.new(1, 0, 1, 0)
        SliderValue.Font = Enum.Font.Gotham
        SliderValue.Text = "1000"
        SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderValue.TextSize = 14.000

        MinSlider.Name = "MinSlider"
        MinSlider.Parent = SliderModule
        MinSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        MinSlider.BackgroundTransparency = 1.000
        MinSlider.BorderSizePixel = 0
        MinSlider.Position = UDim2.new(0.296728969, 40, 0.236842096, 0)
        MinSlider.Size = UDim2.new(0, 20, 0, 20)
        MinSlider.Font = Enum.Font.Gotham
        MinSlider.Text = "-"
        MinSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
        MinSlider.TextSize = 24.000
        MinSlider.TextWrapped = true

        AddSlider.Name = "AddSlider"
        AddSlider.Parent = SliderModule
        AddSlider.AnchorPoint = Vector2.new(0, 0.5)
        AddSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AddSlider.BackgroundTransparency = 1.000
        AddSlider.BorderSizePixel = 0
        AddSlider.Position = UDim2.new(0.810906529, 0, 0.5, 0)
        AddSlider.Size = UDim2.new(0, 20, 0, 20)
        AddSlider.Font = Enum.Font.Gotham
        AddSlider.Text = "+"
        AddSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
        AddSlider.TextSize = 24.000
        AddSlider.TextWrapped = true

        local funcs = {
          SetValue = function(self, value)
            local percent = (mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X
            if value then
              percent = (value - min) / (max - min)
            end
            percent = math.clamp(percent, 0, 1)
            if precise then
              value = value or tonumber(string.format("%.1f", tostring(min + (max - min) * percent)))
             else
              value = value or math.floor(min + (max - min) * percent)
            end
            library.flags[flag] = tonumber(value)
            SliderValue.Text = tostring(value)
            SliderPart.Size = UDim2.new(percent, 0, 1, 0)
            callback(tonumber(value))
          end
        }

        MinSlider.MouseButton1Click:Connect(function()
          local currentValue = library.flags[flag]
          currentValue = math.clamp(currentValue - 1, min, max)
          funcs:SetValue(currentValue)
        end)

        AddSlider.MouseButton1Click:Connect(function()
          local currentValue = library.flags[flag]
          currentValue = math.clamp(currentValue + 1, min, max)
          funcs:SetValue(currentValue)
        end)

        funcs:SetValue(default)

        local dragging, boxFocused, allowed = false, false, {
          [""] = true,
          ["-"] = true
        }

        SliderBar.InputBegan:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 then
            funcs:SetValue()
            dragging = true
          end
        end)

        services.UserInputService.InputEnded:Connect(function(input)
          if dragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
          end
        end)

        services.UserInputService.InputChanged:Connect(function(input)
          if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            funcs:SetValue()
          end
        end)

        SliderBar.InputBegan:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.Touch then
            funcs:SetValue()
            dragging = true
          end
        end)

        services.UserInputService.InputEnded:Connect(function(input)
          if dragging and input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
          end
        end)

        services.UserInputService.InputChanged:Connect(function(input)
          if dragging and input.UserInputType == Enum.UserInputType.Touch then
            funcs:SetValue()
          end
        end)

        SliderValue.Focused:Connect(function()
          boxFocused = true
        end)

        SliderValue.FocusLost:Connect(function()
          boxFocused = false
          if SliderValue.Text == "" then
            funcs:SetValue(default)
          end
        end)

        SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
          if not boxFocused then return end
          SliderValue.Text = SliderValue.Text:gsub("%D+", "")

          local text = SliderValue.Text

          if not tonumber(text) then
            SliderValue.Text = SliderValue.Text:gsub('%D+', '')
           elseif not allowed[text] then
            if tonumber(text) > max then
              text = max
              SliderValue.Text = tostring(max)
            end
            funcs:SetValue(tonumber(text))
          end
        end)

        return funcs
      end
      function section.Dropdown(section, text, flag, options, callback)
        local callback = callback or function() end
        local options = options or {}
        assert(text, "No text provided")
        assert(flag, "No flag provided")

        library.flags[flag] = nil

        local DropdownModule = Instance.new("Frame")
        local DropdownTop = Instance.new("TextButton")
        local DropdownTopC = Instance.new("UICorner")
        local DropdownOpen = Instance.new("TextButton")
        local DropdownText = Instance.new("TextBox")
        local DropdownModuleL = Instance.new("UIListLayout")
        local Option = Instance.new("TextButton")
        local OptionC = Instance.new("UICorner")

        DropdownModule.Name = "DropdownModule"
        DropdownModule.Parent = Objs
        DropdownModule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownModule.BackgroundTransparency = 1.000
        DropdownModule.BorderSizePixel = 0
        DropdownModule.ClipsDescendants = true
        DropdownModule.Position = UDim2.new(0, 0, 0, 0)
        DropdownModule.Size = UDim2.new(0, 428, 0, 38)

        DropdownTop.Name = "DropdownTop"
        DropdownTop.Parent = DropdownModule
        DropdownTop.BackgroundColor3 = zyColor
        DropdownTop.BorderSizePixel = 0
        DropdownTop.Size = UDim2.new(0, 428, 0, 38)
        DropdownTop.AutoButtonColor = false
        DropdownTop.Font = Enum.Font.GothamSemibold
        DropdownTop.Text = ""
        DropdownTop.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropdownTop.TextSize = 16.000
        DropdownTop.TextXAlignment = Enum.TextXAlignment.Left

        DropdownTopC.CornerRadius = UDim.new(0, 6)
        DropdownTopC.Name = "DropdownTopC"
        DropdownTopC.Parent = DropdownTop

        DropdownOpen.Name = "DropdownOpen"
        DropdownOpen.Parent = DropdownTop
        DropdownOpen.AnchorPoint = Vector2.new(0, 0.5)
        DropdownOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownOpen.BackgroundTransparency = 1.000
        DropdownOpen.BorderSizePixel = 0
        DropdownOpen.Position = UDim2.new(0.918383181, 0, 0.5, 0)
        DropdownOpen.Size = UDim2.new(0, 20, 0, 20)
        DropdownOpen.Font = Enum.Font.Gotham
        DropdownOpen.Text = "+"
        DropdownOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropdownOpen.TextSize = 24.000
        DropdownOpen.TextWrapped = true

        DropdownText.Name = "DropdownText"
        DropdownText.Parent = DropdownTop
        DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        DropdownText.BackgroundTransparency = 1.000
        DropdownText.BorderSizePixel = 0
        DropdownText.Position = UDim2.new(0.0373831764, 0, 0, 0)
        DropdownText.Size = UDim2.new(0, 184, 0, 38)
        DropdownText.Font = Enum.Font.GothamSemibold
        DropdownText.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
        DropdownText.PlaceholderText = text
        DropdownText.Text = ""
        DropdownText.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropdownText.TextSize = 16.000
        DropdownText.TextXAlignment = Enum.TextXAlignment.Left

        DropdownModuleL.Name = "DropdownModuleL"
        DropdownModuleL.Parent = DropdownModule
        DropdownModuleL.SortOrder = Enum.SortOrder.LayoutOrder
        DropdownModuleL.Padding = UDim.new(0, 4)

        local setAllVisible = function()
          local options = DropdownModule:GetChildren()
          for i=1, #options do
            local option = options[i]
            if option:IsA("TextButton") and option.Name:match("Option_") then
              option.Visible = true
            end
          end
        end

        local searchDropdown = function(text)
          local options = DropdownModule:GetChildren()
          for i=1, #options do
            local option = options[i]
            if text == "" then
              setAllVisible()
             else
              if option:IsA("TextButton") and option.Name:match("Option_") then
                if option.Text:lower():match(text:lower()) then
                  option.Visible = true
                 else
                  option.Visible = false
                end
              end
            end
          end
        end

        local open = false
        local ToggleDropVis = function()
          open = not open
          if open then setAllVisible() end
          DropdownOpen.Text = (open and "-" or "+")
          DropdownModule.Size = UDim2.new(0, 428, 0, (open and DropdownModuleL.AbsoluteContentSize.Y + 4 or 38))
        end

        DropdownOpen.MouseButton1Click:Connect(ToggleDropVis)
        DropdownText.Focused:Connect(function()
          if open then return end
          ToggleDropVis()
        end)

        DropdownText:GetPropertyChangedSignal("Text"):Connect(function()
          if not open then return end
          searchDropdown(DropdownText.Text)
        end)

        DropdownModuleL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
          if not open then return end
          DropdownModule.Size = UDim2.new(0, 428, 0, (DropdownModuleL.AbsoluteContentSize.Y + 4))
        end)

        local funcs = {}
        funcs.AddOption = function(self, option)
          local Option = Instance.new("TextButton")
          local OptionC = Instance.new("UICorner")

          Option.Name = "Option_" .. option
          Option.Parent = DropdownModule
          Option.BackgroundColor3 = zyColor
          Option.BorderSizePixel = 0
          Option.Position = UDim2.new(0, 0, 0.328125, 0)
          Option.Size = UDim2.new(0, 428, 0, 26)
          Option.AutoButtonColor = false
          Option.Font = Enum.Font.Gotham
          Option.Text = option
          Option.TextColor3 = Color3.fromRGB(255, 255, 255)
          Option.TextSize = 14.000

          OptionC.CornerRadius = UDim.new(0, 6)
          OptionC.Name = "OptionC"
          OptionC.Parent = Option

          Option.MouseButton1Click:Connect(function()
            ToggleDropVis()
            callback(Option.Text)
            DropdownText.Text = Option.Text
            library.flags[flag] = Option.Text
          end)
        end

        funcs.RemoveOption = function(self, option)
          local option = DropdownModule:FindFirstChild("Option_" .. option)
          if option then option:Destroy() end
        end

        funcs.SetOptions = function(self, options)
          for _, v in next, DropdownModule:GetChildren() do
            if v.Name:match("Option_") then
              v:Destroy()
            end
          end
          for _,v in next, options do
            funcs:AddOption(v)
          end
        end

        funcs:SetOptions(options)

        return funcs
      end
      return section
    end
    return tab
  end
  return window
end

local win = library:new("老猫--木材大亨2")
local Tab1 = win:Tab("玩家功能", "10882439086")
local Section3 = Tab1:section("玩家")
local Sectioncs = Tab1:section("传送")
local Sectionqccs = Tab1:section("汽车传送")
local Tab = win:Tab("主要功能", "10728953248")
local Section = Tab:section("斧头")
local Section1 = Tab:section("基地")
local Sectionchuanson = Tab:section("传送东西")
local Sectionzhengli = Tab:section("整理")
local Section5 = Tab:section("木头")
local Tab2 = win:Tab("环境", "4626047596")
local Sectionhuanjin = Tab2:section("环境")
local Tab3 = win:Tab("自动购买暂时不可用", "558024189")
local Sectionautobuy = Tab3:section("自动购买V2(测试)暂时不可用",false)
local Sectionautobuy6 = Tab3:section("其他",false)

Section3:Textbox("设置速度","TextBoxfalg","输入数字",function(s)

  spawn(function()
    while task.wait() do
      lp.Character.Humanoid.WalkSpeed = s
    end
  end)
end)
Section3:Textbox("设置跳跃","TextBoxfalg","输入数字",function(s)

  spawn(function()
    while task.wait() do
      game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = s
    end
  end)
end)
Section3:Textbox("设置高度","TextBoxfalg","输入数字",function(s)
  lp.Character.Humanoid.HipHeight=s
end)
Section3:Button("飞行", function()
  local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local TextLabel = Instance.new("TextLabel")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local mine = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")
local mini = Instance.new("TextButton")
local mini2 = Instance.new("TextButton")

main.Name = "main"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(163, 255, 137)
Frame.BorderColor3 = Color3.fromRGB(103, 221, 213)
Frame.Position = UDim2.new(0.100320168, 0, 0.379746825, 0)
Frame.Size = UDim2.new(0, 190, 0, 57)

up.Name = "up"
up.Parent = Frame
up.BackgroundColor3 = Color3.fromRGB(79, 255, 152)
up.Size = UDim2.new(0, 44, 0, 28)
up.Font = Enum.Font.SourceSans
up.Text = "up"
up.TextColor3 = Color3.fromRGB(0, 0, 0)
up.TextSize = 14.000

down.Name = "down"
down.Parent = Frame
down.BackgroundColor3 = Color3.fromRGB(215, 255, 121)
down.Position = UDim2.new(0, 0, 0.491228074, 0)
down.Size = UDim2.new(0, 44, 0, 28)
down.Font = Enum.Font.SourceSans
down.Text = "down"
down.TextColor3 = Color3.fromRGB(0, 0, 0)
down.TextSize = 14.000

onof.Name = "onof"
onof.Parent = Frame
onof.BackgroundColor3 = Color3.fromRGB(255, 249, 74)
onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
onof.Size = UDim2.new(0, 56, 0, 28)
onof.Font = Enum.Font.SourceSans
onof.Text = "fly"
onof.TextColor3 = Color3.fromRGB(0, 0, 0)
onof.TextSize = 14.000

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(242, 60, 255)
TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 100, 0, 28)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Fly GUI V3"
TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

plus.Name = "plus"
plus.Parent = Frame
plus.BackgroundColor3 = Color3.fromRGB(133, 145, 255)
plus.Position = UDim2.new(0.231578946, 0, 0, 0)
plus.Size = UDim2.new(0, 45, 0, 28)
plus.Font = Enum.Font.SourceSans
plus.Text = "+"
plus.TextColor3 = Color3.fromRGB(0, 0, 0)
plus.TextScaled = true
plus.TextSize = 14.000
plus.TextWrapped = true

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
speed.Size = UDim2.new(0, 44, 0, 28)
speed.Font = Enum.Font.SourceSans
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(0, 0, 0)
speed.TextScaled = true
speed.TextSize = 14.000
speed.TextWrapped = true

mine.Name = "mine"
mine.Parent = Frame
mine.BackgroundColor3 = Color3.fromRGB(123, 255, 247)
mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
mine.Size = UDim2.new(0, 45, 0, 29)
mine.Font = Enum.Font.SourceSans
mine.Text = "-"
mine.TextColor3 = Color3.fromRGB(0, 0, 0)
mine.TextScaled = true
mine.TextSize = 14.000
mine.TextWrapped = true

closebutton.Name = "Close"
closebutton.Parent = main.Frame
closebutton.BackgroundColor3 = Color3.fromRGB(225, 25, 0)
closebutton.Font = "SourceSans"
closebutton.Size = UDim2.new(0, 45, 0, 28)
closebutton.Text = "X"
closebutton.TextSize = 30
closebutton.Position =  UDim2.new(0, 0, -1, 27)

mini.Name = "minimize"
mini.Parent = main.Frame
mini.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini.Font = "SourceSans"
mini.Size = UDim2.new(0, 45, 0, 28)
mini.Text = "T"
mini.TextSize = 30
mini.Position = UDim2.new(0, 44, -1, 27)

mini2.Name = "minimize2"
mini2.Parent = main.Frame
mini2.BackgroundColor3 = Color3.fromRGB(192, 150, 230)
mini2.Font = "SourceSans"
mini2.Size = UDim2.new(0, 45, 0, 28)
mini2.Text = "T"
mini2.TextSize = 30
mini2.Position = UDim2.new(0, 44, -1, 57)
mini2.Visible = false

speeds = 1

local speaker = game:GetService("Players").LocalPlayer

local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

nowe = false

game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "Fly GUI V3";
	Text = "lnjection succeeded";
	Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150"})
Duration = 5;

Frame.Active = true -- main = gui
Frame.Draggable = true

onof.MouseButton1Down:connect(function()

	if nowe == true then
		nowe = false

		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		nowe = true



		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end




	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end
			--	game.Players.LocalPlayer.Character.Animate.Disabled = true
			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false




	else
		local plr = game.Players.LocalPlayer
		local UpperTorso = plr.Character.UpperTorso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0


		local bg = Instance.new("BodyGyro", UpperTorso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = UpperTorso.CFrame
		local bv = Instance.new("BodyVelocity", UpperTorso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			wait()

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
				end
			elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
				speed = speed-1
				if speed < 0 then
					speed = 0
				end
			end
			if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
				lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
			elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
				bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
			else
				bv.velocity = Vector3.new(0,0,0)
			end

			bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
		end
		ctrl = {f = 0, b = 0, l = 0, r = 0}
		lastctrl = {f = 0, b = 0, l = 0, r = 0}
		speed = 0
		bg:Destroy()
		bv:Destroy()
		plr.Character.Humanoid.PlatformStand = false
		game.Players.LocalPlayer.Character.Animate.Disabled = false
		tpwalking = false



	end





end)

local tis

up.MouseButton1Down:connect(function()
	tis = up.MouseEnter:connect(function()
		while tis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
		end
	end)
end)

up.MouseLeave:connect(function()
	if tis then
		tis:Disconnect()
		tis = nil
	end
end)

local dis

down.MouseButton1Down:connect(function()
	dis = down.MouseEnter:connect(function()
		while dis do
			wait()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
		end
	end)
end)

down.MouseLeave:connect(function()
	if dis then
		dis:Disconnect()
		dis = nil
	end
end)


game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
	wait(0.7)
	game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
	game.Players.LocalPlayer.Character.Animate.Disabled = false

end)


plus.MouseButton1Down:connect(function()
	speeds = speeds + 1
	speed.Text = speeds
	if nowe == true then


		tpwalking = false
		for i = 1, speeds do
			spawn(function()

				local hb = game:GetService("RunService").Heartbeat	


				tpwalking = true
				local chr = game.Players.LocalPlayer.Character
				local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
				while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end

			end)
		end
	end
end)
mine.MouseButton1Down:connect(function()
	if speeds == 1 then
		speed.Text = 'flyno1'
		wait(1)
		speed.Text = speeds
	else
		speeds = speeds - 1
		speed.Text = speeds
		if nowe == true then
			tpwalking = false
			for i = 1, speeds do
				spawn(function()

					local hb = game:GetService("RunService").Heartbeat	


					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
						if hum.MoveDirection.Magnitude > 0 then
							chr:TranslateBy(hum.MoveDirection)
						end
					end

				end)
			end
		end
	end
end)

closebutton.MouseButton1Click:Connect(function()
	main:Destroy()
end)

mini.MouseButton1Click:Connect(function()
	up.Visible = false
	down.Visible = false
	onof.Visible = false
	plus.Visible = false
	speed.Visible = false
	mine.Visible = false
	mini.Visible = false
	mini2.Visible = true
	main.Frame.BackgroundTransparency = 1
	closebutton.Position =  UDim2.new(0, 0, -1, 57)
end)

mini2.MouseButton1Click:Connect(function()
	up.Visible = true
	down.Visible = true
	onof.Visible = true
	plus.Visible = true
	speed.Visible = true
	mine.Visible = true
	mini.Visible = true
	mini2.Visible = false
	main.Frame.BackgroundTransparency = 0 
	closebutton.Position =  UDim2.new(0, 0, -1, 27)
end)
Sectioncs:Dropdown("传送","Dropdown",{"恶魔鸭合成地点","裂纹木所在地","回家","连接逻辑店","三叉戟和永恒的合成地","会员商店","画店","桥对岸","沙滩","火木","复仇合成的","神秘小房间","码头","黑市","糖果原","雪地入口","盖克斯航运","玻璃冰木入口","云层","山边商品","章鱼哥祭坛","沼泽商店","石头商店","沼泽","冰胡","星星岛","辐射商店","核污染区","种子商人","小屋已被删除","家具店","车店","罗布克斯商店","肯德坤专卖店","秋季商店"}, function(b)
  list = b
  if list == "恶魔鸭合成地点"then
    tp(CFrame.new(-208.76177978515625, 59.79999542236328, 924.8598022460938))

   elseif list == "裂纹木所在地"then
    tp(CFrame.new(-7612.0859375, 319.6391296386719, 4276.14990234375))

   elseif list == "神秘小房间" then

    tp(CFrame.new(-7229.9619140625, 390.3774108886719, 4686.23486328125))

   elseif list == "连接逻辑店" then
    tp(CFrame.new(4607, 9, -798))

   elseif list == "复仇合成地" then
    tp(CFrame.new(6458.20703125, -85.10005187988281, -4557.05224609375))

   elseif list == "三叉戟和永恒的合成地" then
    tp(CFrame.new(-374.26605224609375, 15.62093734741211, -1340.554443359375))

   elseif list == "画店" then
    tp(CFrame.new(5207, -156, 719))

   elseif list == "火木" then
    tp(CFrame.new(-1585, 625, 1140))

   elseif list == "沙滩" then
    tp(CFrame.new(2549, 5, -42))

   elseif list == "桥对岸"then
    tp(CFrame.new(109,5,-1166))

   elseif list == "会员商店" then
    tp(CFrame.new(907,4,-92))

   elseif list == "码头" then
    tp(CFrame.new(1122,1,-203))

   elseif list == "黑市" then
    tp(CFrame.new(-22,61,1377))

   elseif list == "糖果原" then
    tp(CFrame.new(-561,272,2312))

   elseif list == "雪地入口"then
    tp(CFrame.new(-712.809, 26.8001, -248.328))

   elseif list == "盖克斯航运"then
    tp(CFrame.new(1894,-2,1581))

   elseif list == "玻璃冰木入口" then
    tp(CFrame.new(2305.939697265625, 255.29136657714844, 2976.620361328125))

   elseif list == "云层" then
    tp(CFrame.new(2073,495,2967))

   elseif list == "山边商品"then
    tp(CFrame.new(-640,160,374))

   elseif list == "章鱼哥祭坛" then
    tp(CFrame.new(-1622,196,941))

   elseif list == "沼泽商店" then
    tp(CFrame.new(-1274,133,-1443))

   elseif list == "沼泽" then
    tp(CFrame.new(-999,133,-1191))

   elseif list == "石头商店" then
    tp(CFrame.new(-2387,302,-1899))

   elseif list == "冰胡" then
    tp(CFrame.new(-2149,321,743))

   elseif list == "星星岛" then
    tp(CFrame.new(-520.5476684570312, -87.6123046875, -2028.247802734375))

   elseif list == "辐射商店" then
    tp(CFrame.new(172,12,-2627))

   elseif list == "核污染区" then
    tp(CFrame.new(207,15,-2752))

   elseif list == "种子商人" then
    tp(CFrame.new(-24,18,-2684))

   elseif list == "小屋已被删除" then
    tp(CFrame.new(261,9,-2541))

   elseif list == "家具店" then
    tp(CFrame.new(492,4,-1723))

   elseif list == "车店" then
    tp(CFrame.new(512,4,-1459))

   elseif list == "罗布克斯商店" then
    tp(CFrame.new(652,4,-1589))

   elseif list == "肯德坤专卖店" then
    tp(CFrame.new(65,4,-455))

   elseif list == "秋季商店" then
    tp(CFrame.new(6004,4,33))
   elseif list == "回家" then
    for i,v in pairs(game.Workspace.Properties:GetChildren()) do
      if v.Owner.Value == lp then
        tp(v.OriginSquare.CFrame + Vector3.new(0,10,0))
      end
    end
  end




end)

Sectionqccs:Dropdown("汽车传送","Dropdown",{"恶魔鸭合成地点","回家","裂纹木所在地","连接逻辑店","三叉戟和永恒合成地","会员商店","画店","桥对岸","沙滩","火木","复仇合成地","神秘小房间","码头","黑市","糖果原","雪地入口","盖克斯航运","玻璃冰木入口","云层","山边商品","章鱼哥祭坛","沼泽商店","石头商店","沼泽","冰胡","星星岛","辐射商店","核污染区","种子商人","鲍勃的店","家具店","车店","罗布克斯商店","肯德坤专卖店","秋季商店"}, function(v)
  list = v
  if list == "恶魔鸭合成地点"then

    cartp(CFrame.new(187,5,55))

   elseif list == "裂纹木所在地"then

    cartp(CFrame.new(-7612.0859375, 319.6391296386719, 4276.14990234375))

   elseif list == "神秘小房间" then

    cartp(CFrame.new(3581, -177, 430))

   elseif list == "连接逻辑店" then

    cartp(CFrame.new(4607, 9, -740))

   elseif list == "复仇和成地" then

    cartp(CFrame.new(1451.66248, 412.208405, 3183.47607))

   elseif list == "三叉戟和永恒合成地" then

    cartp(CFrame.new(230, 5, -99))

   elseif list == "画店" then

    cartp(CFrame.new(5207, -156, 719))

   elseif list == "火木" then

    cartp(CFrame.new(-1585, 625, 1140))

   elseif list == "沙滩" then

    cartp(CFrame.new(2549, 5, -42))

   elseif list == "桥对岸"then

    cartp(CFrame.new(109,5,-1166))

   elseif list == "会员商店" then

    cartp(CFrame.new(907,4,-115))

   elseif list == "码头" then

    cartp(CFrame.new(1122,1,-203))

   elseif list == "黑市" then

    cartp(CFrame.new(-15,61,1365))

   elseif list == "糖果原" then

    cartp(CFrame.new(-561,272,2312))

   elseif list == "雪地入口"then

    cartp(CFrame.new(888,61,1188))

   elseif list == "盖克斯航运"then

    cartp(CFrame.new(1894,-2,1581))

   elseif list == "雪屋" then

    cartp(CFrame.new(1929,256,2918))

   elseif list == "云层" then

    cartp(CFrame.new(2060,495,2967))

   elseif list == "山边商品"then

    cartp(CFrame.new(-640,160,374))

   elseif list == "章鱼哥祭坛不要传送有bug" then

    cartp(CFrame.new(-1622,196,941))

   elseif list == "沼泽商店" then

    cartp(CFrame.new(-1274,133,-1443))

   elseif list == "沼泽" then

    cartp(CFrame.new(-999,133,-1191))

   elseif list == "石头商店" then

    cartp(CFrame.new(-2395,302,-1899))

   elseif list == "冰胡" then

    cartp(CFrame.new(-2149,321,743))

   elseif list == "星星岛" then

    cartp(CFrame.new(-612,46,-3169))

   elseif list == "辐射商店" then

    cartp(CFrame.new(172,12,-2627))

   elseif list == "核污染区" then

    cartp(CFrame.new(207,15,-2752))

   elseif list == "种子商人" then

    cartp(CFrame.new(-15,18,-2680))

   elseif list == "鲍勃的店" then

    cartp(CFrame.new(-712.809, 26.8001, -248.328))

   elseif list == "家具店" then

    cartp(CFrame.new(490,4,-1690))

   elseif list == "车店" then

    cartp(CFrame.new(512,4,-1490))

   elseif list == "罗布克斯商店" then

    cartp(CFrame.new(652,4,-1565))

   elseif list == "肯德坤专卖店" then

    cartp(CFrame.new(100,4,-455))

   elseif list == "秋季商店" then

    cartp(CFrame.new(6004,4,33))
   elseif list == "回家" then
    for i,v in pairs(game.Workspace.Properties:GetChildren()) do
      if v.Owner.Value == lp then
        cartp(v.OriginSquare.CFrame + Vector3.new(0,10,0))
      end
    end
  end





end)

Section:Button("复制斧头", function()
  Dupeaxe()
end)
Section:Button("扔掉所有斧头", function()
  for i,v in pairs(game:service"Players".LocalPlayer.Backpack:GetChildren()) do
    if v.Name == "Tool" then
      game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v,"Drop tool",game:service"Players".LocalPlayer.Character.Torso.CFrame * CFrame.new(0,5,0))
    end
  end
end)
Section:Button("捡斧头", function()
  for a,b in pairs(workspace.PlayerModels:GetChildren()) do
    if b:FindFirstChild("Owner") and b.Owner.Value == lp then
      if b:FindFirstChild("Type") and b.Type.Value == "Tool" then
        game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(b,"Pick up Vengeance")
        task.wait()

      end
    end
  end
end)

Section:Toggle("自动复制斧头","Toggleflag",false,function(state)
  if state then
    bai.autoaxedupe=true

    while bai.autoaxedupe ==true do

      Dupeaxe()

    end
   else
    bai.autoaxedupe=false
  end
end)

Section1:Textbox("加载基地数字","TextBoxfalg","输入数字",function(s)
  bai.slot=s
end)
Section1:Button("加载（不保存当前基地）", function()
  ScriptLoadOrSave = true
  local CheckSlot = CheckSlotNumber()
  if CheckSlot ~= false then
    if CheckIfSlotAvailable(CheckSlot) == true then
      local LoadSlot = game.ReplicatedStorage.LoadSaveRequests.RequestLoad:InvokeServer(CheckSlot)
      if LoadSlot == false then
        notify("老猫", "现在不能加载!", 1)
      end
      if LoadSlot == true then
        notify("老猫", "已加载!", 2)
        CurrentSlot = CheckSlot
      end
     else
      notify("老猫", "貌似不工作了☹️", 2)
    end
   else
    notify("老猫", "请你填数字😏", 2)
  end
  ScriptLoadOrSave = false
end)
Section1:Button("保存", function()
  local CheckSlot = CheckSlotNumber()
  if CheckSlot ~= false then
    if CurrentSlot ~= -1 then
      ScriptLoadOrSave = true
      local SaveSlot = game.ReplicatedStorage.LoadSaveRequests.RequestSave:InvokeServer(CheckSlot)
      if SaveSlot == true then
        notify("老猫", "已保存 ✅", 2)
        wait(.5)
        ScriptLoadOrSave = false
       elseif SaveSlot == false then
        notify("老猫", "保存成功!", 1)
        wait(.5)
        ScriptLoadOrSave = false
      end
     else
      notify("老猫", "错误会不会弄!", 1)
    end
   else
    notify("老猫", "你会不会填!", 1)
  end
end)
Section1:Button("免费土地", function()
  for a,b in pairs(workspace.Properties:GetChildren()) do
    if b:FindFirstChild("Owner") and b:FindFirstChild("OriginSquare") and b.Owner.Value == nil then
      game.ReplicatedStorage.PropertyPurchasing.ClientPurchasedProperty:FireServer(b, b.OriginSquare.OriginCFrame.Value.p + Vector3.new(0,3,0))
      wait(0.5)
      Instance.new("RemoteEvent", game:service"ReplicatedStorage".Interaction).Name = "Ban"
      for i,v in pairs(game.Workspace.Properties:GetChildren()) do
        if v.Owner.Value == game.Players.LocalPlayer then
          game.Players.LocalPlayer.Character.Humanoid.Jump = true
          wait(0.1)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.OriginSquare.CFrame + Vector3.new(0,10,0)
          game.Players.LocalPlayer.Character.Humanoid.Jump = true
          wait(0.1)
        end
      end
    end
  end
end)

Section1:Button("最大土地", function()
  for i, v in pairs(game:GetService("Workspace").Properties:GetChildren()) do
    if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
      base = v
      square = v.OriginSquare
    end
  end
  function makebase(pos)
    local Event = game:GetService("ReplicatedStorage").PropertyPurchasing.ClientExpandedProperty
    Event:FireServer(base, pos)
  end
  spos = square.Position
  makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z))
  makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z))
  makebase(CFrame.new(spos.X, spos.Y, spos.Z + 40))
  makebase(CFrame.new(spos.X, spos.Y, spos.Z - 40))
  makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 40))
  makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 40))
  makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 40))
  makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 40))
  makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z))
  makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z))
  makebase(CFrame.new(spos.X, spos.Y, spos.Z + 80))
  makebase(CFrame.new(spos.X, spos.Y, spos.Z - 80))
  --Corners--
  makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 80))
  makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 80))
  makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 80))
  makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 80))
  --Corners--
  makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z + 80))
  makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z + 80))
  makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z + 40))
  makebase(CFrame.new(spos.X + 80, spos.Y, spos.Z - 40))
  makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z + 40))
  makebase(CFrame.new(spos.X - 80, spos.Y, spos.Z - 40))
  makebase(CFrame.new(spos.X + 40, spos.Y, spos.Z - 80))
  makebase(CFrame.new(spos.X - 40, spos.Y, spos.Z - 80))
end)
local Players = Sectionchuanson:Dropdown("选择玩家","Dropdown",bai.dropdown,function(v)
  bai.cswjia= v
end)

Sectionchuanson:Button("重置玩家名称", function()
  shuaxinlb(true)
  Players:SetOptions(bai.dropdown)
end)
local Players = Sectionzhengli:Dropdown("选择玩家","Dropdown",bai.dropdown,function(v)
  bai.zlwjia= v
end)

Sectionchuanson:Button("设置传送点", function()
  pcall(function()
    workspace.baiBasedropCord:Destroy();
    bai.itemset=nil
  end)
  local baiBasedropCord=Instance.new("Part")
  baiBasedropCord.Name="baiBasedropCord";
  baiBasedropCord.Anchored=true;
  baiBasedropCord.Parent=game.Workspace;
  baiBasedropCord.Shape=Enum.PartType.Ball;
  baiBasedropCord.Size=Vector3.new(2,2,2)
  baiBasedropCord.Color=Color3.fromRGB(0, 217, 255);
  baiBasedropCord.Material=Enum.Material.ForceField;
  baiBasedropCord.CFrame=lp.Character.HumanoidRootPart.CFrame
  bai.itemset=lp.Character.HumanoidRootPart.CFrame
end)
Sectionchuanson:Button("删除传送点", function()
  pcall(function()
    workspace.baiBasedropCord:Destroy();
    bai.itemset=nil
  end)

end)
Sectionchuanson:Button("传送东西", function()
  for i=1,20 do
    tpitems("Loose Item")
    wait()
  end
end)
Sectionchuanson:Button("传送斧头", function()
  for i=1,20 do
    tpitems("Tool")
    wait()
  end
end)

Sectionchuanson:Button("传送家具", function()
  for i=1,20 do
    tpitems("Furniture")
    wait()
  end

end)

Sectionchuanson:Button("传送礼物", function()
  for i=1,20 do

    tpitems("Trident")
    wait()
  end
end)
Sectionchuanson:Button("传送木板", function()
  for i=1,20 do
    tpitems("TreeClass")
    wait()
  end
end)
Sectionzhengli:Button("重置玩家名称", function()
  shuaxinlb(true)
  Players:SetOptions(bai.dropdown)
end)

Sectionzhengli:Textbox("x轴","TextBoxfalg","输入数字",function(txt)
  bai.zix=txt
end)
Sectionzhengli:Textbox("z轴","TextBoxfalg","输入数字",function(txt)
  bai.zlz=txt
end)
Sectionzhengli:Button("获取整理工具", function()
  Identify = Instance.new("Tool")
  Identify.RequiresHandle = false;
  Identify.Name = "点击要整理的物品"
  Identify.Activated:connect(function()
    if mouse.Target.Parent:FindFirstChild("PurchasedBoxItemName") then
      bai.dxmz=mouse.Target.Parent.PurchasedBoxItemName.Value
      ItemStackerbox(bai.dxmz,bai.zix, bai.zlz)

     elseif mouse.Target.Parent:FindFirstChild("ItemName") then
      bai.dxmz=mouse.Target.Parent.ItemName.Value
      ItemStackeraxe(bai.dxmz,bai.zix, bai.zlz)
    end
  end)
  Identify.Parent = game.Players.LocalPlayer.Backpack
end)

Section5:Button("传送木头", function()

  local oldPosition = lp.Character.HumanoidRootPart.Position

  for _, Log in pairs(game.Workspace.LogModels:GetChildren()) do
    if Log.Name:sub(1, 6) == "Loose_" and Log:findFirstChild("Owner") then
      if Log.Owner.Value == game.Players.LocalPlayer then
        for _ = 1, 60 do
          tp(Log.WoodSection.CFrame)
          Log:MoveTo(oldPosition)
          tp(oldPosition)
        end
      end
    end
  end

end)
Section5:Button("卖木头", function()
  sellwood()
end)
Section5:Toggle("双倍力量小心可能会把物品弹飞","Toggleflag",false,function(state)
  if state then
    workspace.ChildAdded:connect(function(Dragger)
      if tostring(Dragger)=="Dragger"then
        local BodyGyro=Dragger:WaitForChild"BodyGyro";
        local BodyPosition=Dragger:WaitForChild"BodyPosition";
        repeat game:GetService"RunService".Stepped:wait()until workspace:FindFirstChild"Dragger";

        BodyPosition.P=120000;
        BodyPosition.D=1000;
        BodyPosition.maxForce=Vector3.new(1,1,1)*1000000;
        BodyGyro.maxTorque=Vector3.new(1,1,1)*200;
        BodyGyro.P=1200;
        BodyGyro.D=140;

      end
    end)
   else


    workspace.ChildAdded:connect(function(Dragger)
      if tostring(Dragger)=="Dragger"then
        local BodyGyro=Dragger:WaitForChild"BodyGyro";
        local BodyPosition=Dragger:WaitForChild"BodyPosition";
        repeat game:GetService"RunService".Stepped:wait()until workspace:FindFirstChild"Dragger";


        BodyPosition.P=10000;
        BodyPosition.D=800;
        BodyPosition.maxForce=Vector3.new(17000,17000,17000);
        BodyGyro.maxTorque=Vector3.new(200,200,200);
        BodyGyro.P=1200;
        BodyGyro.D=140;
      end;
    end)

  end
end)
Section5:Toggle("传送木头","Toggleflag",false,function(state)
if state then
  bai.away = true
  while wait() do
    if bai.away == true then
      local oldPosition = lp.Character.HumanoidRootPart.Position

      for _, Log in pairs(game.Workspace.LogModels:GetChildren()) do
        if Log.Name:sub(1, 6) == "Loose_" and Log:findFirstChild("Owner") then
          if Log.Owner.Value == game.Players.LocalPlayer then


              Log:MoveTo(oldPosition)

            
          end
        end
      end
    end
  end
 else
bai.away = false
end     end)

    Section5:Dropdown("选择树","Dropdown",{"普通树","曲奇树","卡通树","幻影树","砖头木","生命树","玻璃冰木","红颜树", "石头木","沼泽黄金", "樱花", "蓝木", "冰木", "火山木", "橡木", "巧克力木", "白桦木", "黄金木", "雪地松", "僵尸木", "大巧克力树", "椰子树","南瓜木","幽灵木","大理石木","天堂木","虚拟木","玻璃木","糖果树","积木树","发光红色糖果木","彩虹树","雷电木","煤炭木","岩浆树","紫木","下水道木","辐射木","地狱木","沙滩木","白洋木","发光彩虹木","布料木","虚空木","裂纹木","幽灵食尸者","金子木","生锈木","土豆木","星空木","只能灾厄砍的","星星木","雪木","死木"},function(b)
      if b=="普通树"then
        bai.cuttreeselect="Generic"
       elseif b=="沼泽黄金"then
        bai.cuttreeselect="GoldSwampy"
       elseif b=="樱花"then
        bai.cuttreeselect="Cherry"
       elseif b=="蓝木"then
        bai.cuttreeselect="CaveCrawler"
       elseif b=="冰木"then
        bai.cuttreeselect="Frost"
       elseif b=="火山木"then
        bai.cuttreeselect="Volcano"
       elseif b=="橡木"then
        bai.cuttreeselect="Oak"
       elseif b=="巧克力木"then
        bai.cuttreeselect="Walnut"
       elseif b=="白桦木"then
        bai.cuttreeselect="Birch"
       elseif b=="黄金木"then
        bai.cuttreeselect="SnowGlow"
       elseif b=="雪地松"then
        bai.cuttreeselect="Pine"
       elseif b=="僵尸木"then
        bai.cuttreeselect="GreenSwampy"
       elseif b=="大巧克力树"then
        bai.cuttreeselect="Koa"
       elseif b=="椰子树"then
        bai.cuttreeselect="Palm"
       elseif b=="幽灵木"then
        bai.cuttreeselect="Spooky"
       elseif b=="南瓜木"then
        bai.cuttreeselect="SpookyNeon"
       elseif b=="大理石木"then
        bai.cuttreeselect="Marble"
       elseif b=="天堂木"then
        bai.cuttreeselect="Sky"
       elseif b=="虚拟木"then
        bai.cuttreeselect="Virtual"
       elseif b=="玻璃木"then
        bai.cuttreeselect="Taco"
       elseif b=="糖果树"then
        bai.cuttreeselect="CandycaneGreen"
       elseif b=="积木树"then
        bai.cuttreeselect="CandycaneRed"
       elseif b=="发光红色糖果木"then
        bai.cuttreeselect="CandyNeon"
       elseif b=="彩虹树"then
        bai.cuttreeselect="Rainbow"
       elseif b=="雷电木"then
        bai.cuttreeselect="Electric"
       elseif b=="煤炭木"then
        bai.cuttreeselect="GenericDead"
       elseif b=="岩浆树"then
        bai.cuttreeselect="Skittles"
       elseif b=="紫木"then
        bai.cuttreeselect="Cavern"
       elseif b=="下水道木"then
        bai.cuttreeselect="MuckySewer"
       elseif b=="辐射木"then
        bai.cuttreeselect="Radioactive"
       elseif b=="地狱木"then
        bai.cuttreeselect="Hell"
       elseif b=="沙滩木"then
        bai.cuttreeselect="Sand"
       elseif b=="白洋木"then
        bai.cuttreeselect="Aspen"
       elseif b=="发光彩虹木"then
        bai.cuttreeselect="NeonRainbow"
       elseif b=="狗木"then
        bai.cuttreeselect="Dog"
       elseif b=="幻影树"then
        bai.cuttreeselect="LoneCave"
       elseif b=="红颜树"then
        bai.cuttreeselect="Shine"
       elseif b=="石头木"then
        bai.cuttreeselect="Magma"
       elseif b=="玻璃冰木"then
        bai.cuttreeselect="Ice"
       elseif b=="砖头木"then
        bai.cuttreeselect="Blah"
       elseif b=="卡通树"then
        bai.cuttreeselect="CobbleStone"
       elseif b=="曲奇树"then
        bai.cuttreeselect="Cookie"
       elseif b=="生命树"then
        bai.cuttreeselect="GreatOak"
       elseif b=="虚空木"then
        bai.cuttreeselect="Void"
       elseif b=="裂纹木"then
        bai.cuttreeselect="Celestial"
       elseif b=="幽灵食尸者"then
        bai.cuttreeselect="SpookyGhoul"
       elseif b=="生锈木"then
        bai.cuttreeselect="SewageTree"
       elseif b=="金子木"then
        bai.cuttreeselect="Gold"
       elseif b=="土豆木"then
        bai.cuttreeselect="BlueFlame"
       elseif b=="星空木"then
        bai.cuttreeselect="Spirit"
       elseif b=="只能灾厄砍的"then
        bai.cuttreeselect="Flame"
       elseif b=="星星木"then
        bai.cuttreeselect="Star"
       elseif b=="雪木"then
        bai.cuttreeselect="Snow"
       elseif b=="死木"then
        bai.cuttreeselect="GenericDead"

      end
    end)
    Section5:Textbox("带来树的数量","TextBoxfalg","输入数字",function(txt)
      bai.bringamount=txt
    end)
    Section5:Button("带来树", function()
      bai.bringtree=true
      for i=1 , bai.bringamount do
        if bai.bringtree==true then
          task.wait()
          bringTree(bai.cuttreeselect)
        end

      end


    end)
    Section5:Button("停止", function()
      bai.bringtree=false
      workspace.Camera.CameraSubject = lp.Character
    end)
    Section5:Button("处理树", function()
      modwood()
    end)
    Sectionhuanjin:Toggle("终日白天","Toggleflag",false, function(state)
      if state then
        bai.awaysday=true
        while task.wait() do
          if bai.awaysday==true then
            game:GetService("Lighting").TimeOfDay=("12:00:00");
          end
        end
       else bai.awaysday=false
      end

    end)
    Sectionhuanjin:Toggle("终日黑天","Toggleflag",false, function(state)
      if state then
        bai.awaysdnight=true
        while task.wait() do
          if bai.awaysdnight==true then
            game:GetService("Lighting").TimeOfDay=("2:00:00");
          end
        end
       else
        bai.awaysdnight=false
      end
    end)
    game:GetService("Lighting").GlobalShadows =true
    Sectionhuanjin:Toggle("消除阴影","Toggleflag",false, function(state)


      if state then
        game:GetService("Lighting").GlobalShadows=false
       else
        game:GetService("Lighting").GlobalShadows=true
      end

    end)
    Sectionhuanjin:Button("删除灵视神殿的石头", function()
      workspace.Region_Mountainside.BoulderRegen.Boulder:Destroy()
      workspace.Region_Mountainside.Door.Door:Destroy()

    end)

    Sectionhuanjin:Button("删除灵视神殿的石头", function()
      workspace.Camera.CameraSubject = lp.Character
    end)

    Sectionhuanjin:Toggle("删除岩浆","Toggleflag",false,function(state)
      for i,v in pairs(game.Workspace.Region_Volcano:GetDescendants()) do
        if v.Name == "TouchInterest" then
          v:Destroy()
         elseif v.Name == "Lava" then
          for n,k in pairs(v:GetChildren()) do
            if k:IsA("Part") then
              if state == true then
                k.Transparency = 1
               else
                k.Transparency = 0
              end
            end
          end
        end
      end
    end)
    Sectionhuanjin:Toggle("删除水","Toggleflag",false,function(state)
      for _,v in pairs(game.Workspace.Water:GetChildren()) do
        if v.Name == "Water" then
          if state then
            v.Transparency = 1;
           else
            v.Transparency = 0;
          end
        end
      end
    end)

    Sectionhuanjin:Toggle("去除雾","Toggleflag",false, function(state)
      if state then
        bai.nofog=true
        while task.wait() do
          if bai.nofog==true then
            game:GetService("Lighting").FogEnd=1000000;
          end
        end
       else bai.nofog=false
      end
    end)
    Sectionhuanjin:Toggle("水上行走","Toggleflag",false, function(state)
      for i,v in next,game.workspace.Water:children()do
        if v.ClassName=="Part"then
          bai.waterwalk,v.CanCollide=state,state;
        end;
      end;
      for i,v in next,game:GetService("Workspace").Bridge.VerticalLiftBridge.WaterModel:children()do
        if v:IsA("BasePart")then
          v.CanCollide=state;
        end;
      end;


    end)
    Sectionhuanjin:Toggle("岩浆行走","Toggleflag",false, function(state)
      for i,v in next,game.workspace.Region_Volcano:children()do
        if v.ClassName=="Part"then
          bai.waterwalk,v.CanCollide=state,state;
        end;
      end;
      for i,v in next,game:GetService("Workspace").Bridge.VerticalLiftBridge.LavaModel:children()do
        if v:IsA("BasePart")then
          v.CanCollide=state;
        end;
      end;


    end)