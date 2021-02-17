pageextension 50001 CBRExtendCustomerList extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Location Code")
        {
            field(City; City)
            {
                ApplicationArea = All;
                Caption = 'City';
            }
            field(County; County)
            {
                ApplicationArea = All;
                Caption = 'County';
            }
            field("Tax Area Code"; "Tax Area Code")
            {
                ApplicationArea = All;
                Caption = 'Tax Area Code';
            }
            field(CBRDefaultPONo; CBRDefaultPONo)
            {
                ApplicationArea = All;
                Caption = 'DefaultPONo';
            }
        }

        addbefore(CustomerStatisticsFactBox)
        {
            part(ItemIncomingAttachments; "Item Incoming Attachments")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");

            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("S&ales")
        {
            action("CBR Page Item Sales History")
            {
                ApplicationArea = all;
                Caption = 'Item Sales History';
                RunObject = page "Item Sales History";
                RunPageLink = "Customer No" = field("No.");
                Promoted = true;
                PromotedIsBig = true;
                Image = History;
                PromotedCategory = Process;
            }
        }

        addafter(AssignTaxArea)
        {
            action("CBR Show All Customer")
            {
                ApplicationArea = All;
                Caption = 'Show All Customer';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditFilter;

                trigger OnAction()
                begin
                    Reset();
                end;
            }

            action("CBR Hide ALL Blocked Customer")
            {
                ApplicationArea = All;
                Caption = 'Hide ALL Blocked Customer';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ShowSelected;

                trigger OnAction()
                begin
                    RESET;
                    SETFILTER(Blocked, '<>%1', Blocked::All);
                end;
            }

        }

    }



    var
        myInt: Integer;
}