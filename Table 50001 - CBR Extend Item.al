tableextension 50001 CBRExtendItem extends Item
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBRUnitCostCommission"; Decimal)
        {
            Caption = 'UnitCostCommission';
            DataClassification = CustomerContent;
            Description = 'CBR_SS';
        }
        field(50001; "CBR Default Selling Price"; Decimal)
        {
            Caption = 'Default Selling Price';
            DataClassification = CustomerContent;
            Description = 'CBR_SS';
        }
    }

    var
        myInt: Integer;
}