pageextension 50016 CBRExtendOrderProcRoleCenter extends "Order Processor Role Center"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Customer)
        {
            action("Vizient Sales")
            {
                CaptionML = ENU = 'Vizient Sales';
                ApplicationArea = Basic, Suite;
                RunObject = Report "Vizient Sales";
                Promoted = true;
                PromotedIsBig = true;
                Image = Sales;
                PromotedCategory = Process;
            }
        }
    }

    var
        myInt: Integer;
}