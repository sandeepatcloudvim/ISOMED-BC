pageextension 50017 CBRExtendPurchaseOrderList extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Order Date"; "Order Date")
            {
                ApplicationArea = All;
                Caption = 'Order Date';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Co&mments")
        {
            action("CBR PO Lines not Invoiced")
            {
                ApplicationArea = All;
                Caption = 'PO Lines not Invoiced';
                Image = OpportunityList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "PO Lines not Invoiced";
            }
            action("CBR PO Shipment Report")
            {
                ApplicationArea = All;
                Caption = 'PO Shipment Report';
                Image = OpportunityList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Purchase Order Shipment";
            }
        }
    }

    var
        myInt: Integer;
}