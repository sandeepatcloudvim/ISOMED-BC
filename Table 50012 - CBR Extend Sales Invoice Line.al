tableextension 50012 CBRExtendSalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(50001; "CBR Repl. Cost"; Decimal)
        {
            Caption = 'Repl. Cost';
            DataClassification = CustomerContent;
            Description = 'CBR-SS-0424-2';

        }
        field(50002; "CBR Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            Editable = false;
        }
        field(50003; "CBR Manufacturer Code"; Code[10])
        {
            Caption = 'Manufacturer Code';
            TableRelation = Manufacturer;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "CBR Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "CBR Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50006; "CBR External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(50007; "CBR Order No"; Code[20])
        {
            Caption = 'Order No';
            DataClassification = CustomerContent;
        }
    }
    trigger OnInsert()
    begin
        //ItemSaleshistory.AutoUpdateItemSalesLines(Rec);//CBR_SS
    end;

    var
        myInt: Integer;
        ItemSaleshistory: Record "CBR Item Sales History";
}