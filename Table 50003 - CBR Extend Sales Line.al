tableextension 50003 CBRExtendSalesLine extends "Sales Line"
{
    fields
    {
        field(50000; "CBR Repl. Cost"; decimal)
        {
            Caption = 'Repl. Cost';
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'CBR-SS-0424-2';
        }
    }

    procedure CBRUpdateReplnCost(VAR SalesLineLocal: Record "Sales Line")
    var
        PurchPrice: Record "Purchase Price";
        PurchPrice2: Record "Purchase Price";
        ItemRec: Record Item;
        PurchPrice3: Record "Purchase Price";
        ItemUOM: Record "Item Unit of Measure";
    begin
        IF NOT ItemRec.GET(SalesLineLocal."No.") THEN
            EXIT;
        IF NOT Updated THEN
            EXIT;

        IF ItemRec."Vendor No." <> '' THEN
            PurchPrice.SETRANGE("Vendor No.", ItemRec."Vendor No.");
        PurchPrice.SETRANGE("Item No.", ItemRec."No.");
        IF PurchPrice.FINDLAST THEN BEGIN
            PurchPrice2.ASCENDING(TRUE);
            PurchPrice2.SETRANGE("Vendor No.", PurchPrice."Vendor No.");
            PurchPrice2.SETRANGE("Item No.", PurchPrice."Item No.");
            IF PurchPrice."Starting Date" <> 0D THEN
                PurchPrice2.SETFILTER("Starting Date", '<=%1', TODAY);
            IF PurchPrice."Ending Date" <> 0D THEN
                PurchPrice2.SETFILTER("Ending Date", '>=%1', TODAY);
            IF PurchPrice2.FINDLAST THEN BEGIN
                PurchPrice3.SETRANGE("Vendor No.", PurchPrice2."Vendor No.");
                PurchPrice3.SETRANGE("Item No.", PurchPrice2."Item No.");
                PurchPrice3.SETRANGE("Starting Date", PurchPrice2."Starting Date");
                PurchPrice3.SETRANGE("Ending Date", PurchPrice2."Ending Date");
                PurchPrice3.SETRANGE("Unit of Measure Code", ItemRec."Sales Unit of Measure");
                IF PurchPrice3.FINDLAST THEN
                    "CBR Repl. Cost" := PurchPrice3."Direct Unit Cost"
                ELSE BEGIN
                    ItemUOM.GET(ItemRec."No.", ItemRec."Purch. Unit of Measure");
                    "CBR Repl. Cost" := PurchPrice2."Direct Unit Cost" / ItemUOM."Qty. per Unit of Measure";
                END;
            END;
        END;
    end;

    procedure CBRUpdateUOMReplnCost(VAR SalesLineLocal: Record "Sales Line")
    var
        ItemRec: Record Item;
        ItemUOM: Record "Item Unit of Measure";
    begin
        IF NOT ItemRec.GET(SalesLineLocal."No.") THEN
            EXIT;
        IF Updated THEN
            EXIT;
        IF xRec."Unit of Measure Code" = Rec."Unit of Measure Code" THEN
            EXIT;
        ItemUOM.GET(ItemRec."No.", "Unit of Measure Code");
        IF ItemRec."Sales Unit of Measure" <> "Unit of Measure Code" THEN
            "CBR Repl. Cost" := "CBR Repl. Cost" * ItemUOM."Qty. per Unit of Measure"
        ELSE BEGIN
            ItemUOM.GET(ItemRec."No.", ItemRec."Purch. Unit of Measure");
            "CBR Repl. Cost" := "CBR Repl. Cost" / ItemUOM."Qty. per Unit of Measure";
        END;
    end;

    var
        updated: Boolean;
}