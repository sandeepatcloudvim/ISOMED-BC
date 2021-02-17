pageextension 50039 CBRExtendPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        modify("No.")
        {
            Caption = 'Invoice No.';
            ApplicationArea = All;
        }
        modify("Amount Including VAT")
        {
            Caption = 'Total with tax';
            ApplicationArea = All;
        }
        modify(Amount)
        {
            Caption = 'Subtotal';
            ApplicationArea = All;
        }
        addafter("Bill-to Name")
        {
            field("Bill-to Address"; "Bill-to Address")
            {
                ApplicationArea = All;
            }
            field("Bill-to Address 2"; "Bill-to Address 2")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Name")
        {
            field("Ship-to Address"; "Ship-to Address")
            {
                ApplicationArea = All;
            }
            field("Ship-to Address 2"; "Ship-to Address 2")
            {
                ApplicationArea = All;
            }
            field("Ship-to City"; "Ship-to City")
            {
                ApplicationArea = All;
            }
            field("Ship-to County"; "Ship-to County")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Package Tracking No."; "Package Tracking No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter("&Invoice")
        {
            action("Vizient Sales")
            {
                CaptionML = ENU = 'Vizient Sales';
                ApplicationArea = Basic, Suite;
                RunObject = Report "Vizient Sales";
                Promoted = true;
                PromotedIsBig = true;
                Image = Sales;
                PromotedCategory = Category7;
            }
            action("Banner Health Sales")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Banner Health Sales';
                RunObject = Report "Banner Health Sales";
                Promoted = true;
                PromotedIsBig = true;
                Image = Sales;
                PromotedCategory = Category7;
            }
            action("CPS Sales")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'CPS Sales';
                RunObject = Report "CPS Sales";
                Promoted = true;
                PromotedIsBig = true;
                Image = Sales;
                PromotedCategory = Category7;
            }
            action("Intelere Sales")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Intelere Sales';
                RunObject = Report "Intalere Sales";
                Promoted = true;
                PromotedIsBig = true;
                Image = Sales;
                PromotedCategory = Category7;
            }
            action("IsoMed Sales Comission")
            {
                CaptionML = ENU = 'IsoMed Sales Comission';
                ApplicationArea = Basic, Suite;
                RunObject = Report "IsoMed Sales Commission";
                Promoted = true;
                PromotedIsBig = true;
                Image = SalesPerson;
                PromotedCategory = Category7;
            }
            action("Manufacturer Sales")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Manufacturer Sales';
                RunObject = Report "Manufacturer Sales Report";
                Promoted = true;
                PromotedIsBig = true;
                Image = Report;
                PromotedCategory = Category7;
            }
            action("Sales by Ship-to")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales by Ship-to';
                RunObject = Report "Sales Invoice - Print Job";
                Promoted = true;
                PromotedIsBig = true;
                Image = Invoice;
                PromotedCategory = Category7;
            }
            action("Item Sales History")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Item Sales History';
                RunObject = page "Item Sales History";
                Promoted = true;
                PromotedIsBig = true;
                Image = ViewPostedOrder;
                PromotedCategory = Category7;
            }
        }
        addafter(Print)
        {
            action("CBR PrintJob")
            {
                ApplicationArea = All;
                Caption = 'PrintJob';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Ellipsis = true;
                //Visible = NOT IsOfficeAddin;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50028, TRUE, FALSE, Rec);
                    RESET;
                end;
            }
        }
    }

    var
        myInt: Integer;
}