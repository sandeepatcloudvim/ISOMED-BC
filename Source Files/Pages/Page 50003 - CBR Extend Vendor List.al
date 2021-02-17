pageextension 50003 CBRExtendVendorList extends "Vendor List"
{
    layout
    {
        addbefore(VendorDetailsFactBox)
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
        addafter(AssignTaxArea)
        {
            action("CBR Show All Vendor")
            {
                ApplicationArea = All;
                Caption = 'Show All Vendor';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = EditFilter;

                trigger OnAction()
                begin
                    Reset();
                end;
            }

            action("CBR Hide ALL Blocked Vendor")
            {
                ApplicationArea = All;
                Caption = 'Hide ALL Blocked Vendor';
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