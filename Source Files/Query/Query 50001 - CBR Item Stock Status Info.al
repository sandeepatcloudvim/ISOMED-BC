query 50001 "Item Stock Status Info"
{
    // version NAVW17.00

    CaptionML = ENU='Lot Numbers by Bin',
                ESM='Números lote por ubicación',
                FRC='Numéros de lot par zone',
                ENC='Lot Numbers by Bin';
    OrderBy = Ascending(Item_No);

    elements
    {
        dataitem(Warehouse_Entry;"Warehouse Entry")
        {
            column(Item_No;"Item No.")
            {
            }
            column(Variant_Code;"Variant Code")
            {
            }
            column(Location_Code;"Location Code")
            {
            }
            column(Zone_Code;"Zone Code")
            {
            }
            column(Bin_Code;"Bin Code")
            {
            }
            column(Lot_No;"Lot No.")
            {
                ColumnFilter = Lot_No=FILTER(<>'');
            }
            column(Sum_Qty_Base;"Qty. (Base)")
            {
                ColumnFilter = Sum_Qty_Base=FILTER(<>0);
                Method = Sum;
            }
        }
    }
}

