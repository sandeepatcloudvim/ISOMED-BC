pageextension 50036 CBRExtendPurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {

    }

    actions
    {
        addafter(BlanketOrder)
        {
            group("ActionGroup")
            {

                Caption = 'Label';
            }
            action("Print Label")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Label';
                Image = Report;
                trigger OnAction()
                var
                    TestReport: Report "Production Label For Item";
                begin
                    //CBR_SS_11/05/2018 >>
                    TESTFIELD("Document No.");
                    TESTFIELD("Line No.");
                    TestReport.InitValue("Document No.", "Line No.");
                    TestReport.RUN;
                    //CBR_SS_11/05/2018 <<
                end;

            }
        }
    }

    var
        myInt: Integer;
}