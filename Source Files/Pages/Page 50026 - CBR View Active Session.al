page 50026 "View Active Session"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    Permissions = TableData "Warehouse Entry" = rimd;
    SourceTable = "Active Session";
    SourceTableView = WHERE("Client Type" = FILTER("Web Client" | "Windows Client"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; "User ID")
                {
                    Caption = 'User ID';
                    ApplicationArea = All;
                }
                field("Client Type"; "Client Type")
                {
                    Caption = 'Client Type';
                    ApplicationArea = All;
                }
                field("Client Computer Name"; "Client Computer Name")
                {
                    Caption = 'Client Computer Name';
                    ApplicationArea = All;
                }
                field("Login Datetime"; "Login Datetime")
                {
                    Caption = 'Login Datetime';
                    ApplicationArea = All;
                }
                field("License Type"; UserSetup."License Type")
                {
                    Caption = 'License Type';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Kill Session")
            {
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(ActiveSession);
                    if Confirm(Text001, true) then begin
                        if ActiveSession.FindSet then
                            repeat
                                StopSession(ActiveSession."Session ID");
                            until ActiveSession.Next = 0
                    end;
                end;
            }
            action(DeleteWHE)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    if WHE.Get(44179) then begin
                        WHE.Quantity := 20;
                        WHE."Qty. (Base)" := 20;
                        WHE.Modify;
                    end
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //CBR_SS ++
        if UserSetup.Get("User ID") then;
        //CBR_SS --
    end;

    var
        ActiveSession: Record "Active Session";
        Text001: Label 'Do you want kill the selected user session ?';
        UserSetup: Record "User Setup";
        WHE: Record "Warehouse Entry";
}

