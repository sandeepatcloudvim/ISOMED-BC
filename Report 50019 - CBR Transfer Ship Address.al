report 50019 "Transfer Ship Address"
{
    Permissions = TableData "Sales Invoice Header" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");

            trigger OnAfterGetRecord()
            begin
                ShiptoAddress.Reset;

                ShiptoAddress.SetRange("Customer No.", "Sell-to Customer No.");
                ShiptoAddress.SetRange(Code, "Ship-to Code");
                if ShiptoAddress.FindSet then
                    repeat
                        "CBR GLN" := ShiptoAddress.GLN;
                        "CBR Member ID" := ShiptoAddress."Member ID";
                        "CBR License No." := ShiptoAddress."License No.";
                        Modify;
                    until ShiptoAddress.Next = 0;
            end;

            trigger OnPostDataItem()
            begin
                Message('Completed');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ShiptoAddress: Record "CBR Ship-to Address2";
}

