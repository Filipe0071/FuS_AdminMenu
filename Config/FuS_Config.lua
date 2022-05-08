FuS_Config = {}

-- {Shared} --
FuS_Config.Legacy = true

-- {Notify Config} -- 
FuS_Config.TimeNotify = 10000 

-- {Set True If Use OxInventory} -- 
FuS_Config.UseOxInventory = true 

-- {Position And Key Menu} --
FuS_Config.PositionMenu = "right"
FuS_Config.KeybindMenu = "HOME"

FuS_Config.TagStaff = "STAFFER"
FuS_Config.DefaultNameGarageSQL = "A"

FuS_Config.NameResourceStatus = "FuS_Gamemode"

-- {Commands For Execute Functions} --
FuS_Config.Commands = {
    Tag = "tagstaff",
    OpenInventory = "openinventory",
    ClearChat = "cls",
    GiveAccountMoney = "giveaccountmoney",
    GiveItem = "giveitem",
    GiveVehicleToPlayer = "daiveicolo"
}

FuS_Config.Triggers = {
    TriggerRevive = "DNC_AmbulanceJob:Revive",
    ChangeAspectSkin = "esx_skin:openSaveableMenu"
}