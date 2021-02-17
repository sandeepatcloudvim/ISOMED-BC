table 50021 "CBR Item Sales History"
{
    DrillDownPageID = "Item Sales History";
    LookupPageID = "Item Sales History";

    fields
    {
        field(1; "Invoice No"; Code[20])
        {
        }
        field(2; "Original Sales Order No"; Code[20])
        {
        }
        field(3; "External Document No."; Code[35])
        {
        }
        field(4; "Customer No"; Code[20])
        {
        }
        field(5; "Salesperson Code"; Code[20])
        {
        }
        field(6; "Customer Name"; Text[50])
        {
        }
        field(7; "Bill-to Address"; Text[50])
        {
        }
        field(8; "Bill-to Address2"; Text[50])
        {
        }
        field(9; "Line No."; Integer)
        {
        }
        field(10; "Bill-to City"; Text[30])
        {
        }
        field(11; "Bill-to State"; Code[20])
        {
        }
        field(12; "Bill-to Zip"; Code[20])
        {
        }
        field(13; "Ship-to Address"; Text[50])
        {
        }
        field(19; "Document Date"; Date)
        {
        }
        field(20; "Posting Date"; Date)
        {
        }
        field(21; "Due date"; Date)
        {
        }
        field(22; "Payment Terms Code"; Code[10])
        {
        }
        field(25; "Shipping Agent Code"; Code[10])
        {
            Description = 'Carrier Code';
        }
        field(26; "Shipping Method Code"; Code[10])
        {
            Description = 'Shipping Carrier Method';
        }
        field(28; "Package Tracking No."; Text[30])
        {
        }
        field(31; "Item No."; Code[20])
        {
        }
        field(32; "Cross Reference No"; Code[20])
        {
        }
        field(33; "Item Description"; Text[200])
        {
        }
        field(34; "Unit of Measure Code"; Code[20])
        {
        }
        field(35; "Qty Invoiced"; Decimal)
        {
        }
        field(36; "Unit Price"; Decimal)
        {
        }
        field(37; "Extended Price"; Decimal)
        {
        }
        field(38; "Unit Cost (Invoice)"; Decimal)
        {
        }
        field(39; "Unit Cost (Item)"; Decimal)
        {
        }
        field(40; "Extended Cost"; Decimal)
        {
            Description = 'Extended Cost from Item Master timesd Qty';
        }
        field(41; "Location Code"; Code[20])
        {
        }
        field(42; "Manufacturer Code"; Code[20])
        {
        }
        field(43; "Vendor No"; Code[20])
        {
        }
        field(44; "Vendor Item No"; Code[20])
        {
        }
        field(45; "Item Category"; Code[20])
        {
        }
        field(46; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(47; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(48; "Error Description"; Text[75])
        {
        }
        field(49; "Customer Price Group"; Code[10])
        {
        }
        field(50; "Customer Disc. Group"; Code[20])
        {
        }
        field(51; "Margin Amount"; Decimal)
        {
        }
        field(52; "Ship-to Address2"; Text[50])
        {
        }
        field(53; "Ship-to City"; Text[30])
        {
        }
        field(54; "Ship-to State"; Code[20])
        {
        }
        field(55; "Ship-to Zip"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Invoice No", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure ShowItemTrackingLines()
    var
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
    begin
        //ItemTrackingDocMgt.ShowItemTrackingForInvoiceLine(RowID1);
    end;


    procedure RowID1(): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        SinvLine: Record "Sales Invoice Line";
    begin
        SinvLine.Reset;
        SinvLine.SetRange("Document No.", "Invoice No");
        SinvLine.SetRange("Line No.", "Line No.");
        if SinvLine.FindFirst then;

        // exit(ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line",
        //     0, SinvLine."Document No.", '', 0, SinvLine."Line No."));
    end;


    procedure UpdateItemHistory()
    var
        SalesInvHead: Record "Sales Invoice Header";
        SalesInvLine: Record "Sales Invoice Line";
        ItemSalesHistory: Record "CBR Item Sales History";
    begin
        if not Confirm('Do you want to refresh data into Item Sales History Table, this action will delete all of the existing sales history lines and re-populate the data from posted Sales Invoice', false) then
            exit;
        ItemSalesHistory.DeleteAll;

        SalesInvHead.Reset;
        if SalesInvHead.Find('-') then
            repeat
                if not IFItemSalesLinesExit(SalesInvHead) then begin
                    SalesInvLine.Reset;
                    SalesInvLine.SetRange("Document No.", SalesInvHead."No.");
                    SalesInvLine.SetRange(Type, SalesInvLine.Type::Item);
                    //SalesInvLine.SETRANGE("No.",'<>%1','*@ZZ*');
                    if SalesInvLine.FindSet then
                        repeat
                            CreateLines(SalesInvHead, SalesInvLine);
                        until SalesInvLine.Next = 0;
                end;
            until SalesInvHead.Next = 0;
        Message('Completed Successfully');
    end;


    procedure CreateLines(SInvHead: Record "Sales Invoice Header"; SInvLine: Record "Sales Invoice Line")
    var
        ItemSalesHistory: Record "CBR Item Sales History";
        Item: Record Item;
    begin

        with ItemSalesHistory do begin
            Init;
            "Invoice No" := SInvHead."No.";
            "Line No." := SInvLine."Line No.";
            if not Item.Get(SInvLine."No.") then
                "Error Description" := 'Item No. :' + SInvLine."No." + ' ' + 'does not exist in the item table';
            "Original Sales Order No" := SInvHead."Order No.";
            "External Document No." := SInvHead."External Document No.";
            "Customer No" := SInvHead."Sell-to Customer No.";
            "Salesperson Code" := SInvHead."Salesperson Code";
            "Customer Name" := SInvHead."Sell-to Customer Name";
            "Bill-to Address" := SInvHead."Bill-to Address";
            "Bill-to Address2" := SInvHead."Bill-to Address 2";
            "Bill-to City" := SInvHead."Bill-to City";
            "Bill-to State" := SInvHead."Bill-to County";
            "Bill-to Zip" := SInvHead."Bill-to Post Code";

            "Ship-to Address" := SInvHead."Ship-to Address";
            "Ship-to Address2" := SInvHead."Ship-to Address 2";
            "Ship-to City" := SInvHead."Ship-to City";
            "Ship-to State" := SInvHead."Ship-to County";
            "Ship-to Zip" := SInvHead."Ship-to Post Code";

            "Document Date" := SInvHead."Document Date";
            "Posting Date" := SInvHead."Posting Date";
            "Due date" := SInvHead."Due Date";
            "Payment Terms Code" := SInvHead."Payment Terms Code";
            "Shipping Agent Code" := SInvHead."Shipping Agent Code";
            "Shipping Method Code" := SInvHead."Shipment Method Code";
            "Package Tracking No." := SInvHead."Package Tracking No.";
            "Customer Disc. Group" := SInvHead."Customer Disc. Group";
            "Customer Price Group" := SInvHead."Customer Price Group";
            "Item No." := SInvLine."No.";
            "Item Description" := SInvLine.Description;
            "Cross Reference No" := SInvLine."Cross-Reference No.";
            "Unit of Measure Code" := SInvLine."Unit of Measure Code";
            "Qty. per Unit of Measure" := SInvLine."Qty. per Unit of Measure";
            "Qty Invoiced" := SInvLine.Quantity;
            "Unit Price" := SInvLine."Unit Price";
            "Extended Price" := SInvLine.Quantity * "Unit Price";
            "Unit Cost (Invoice)" := SInvLine."Unit Cost";
            if Item."Unit Cost" > 0 then begin
                "Unit Cost (Item)" := Item."Unit Cost";
                "Extended Cost" := ((SInvLine.Quantity * SInvLine."Qty. per Unit of Measure") * Item."Unit Cost");
            end else begin
                "Unit Cost (Item)" := SInvLine."Unit Cost";
                "Extended Cost" := ((SInvLine.Quantity * SInvLine."Qty. per Unit of Measure") * SInvLine."Unit Cost");
            end;

            "Margin Amount" := "Extended Price" - "Extended Cost";
            "Location Code" := SInvHead."Location Code";
            "Item Category" := SInvLine."Item Category Code";
            "Manufacturer Code" := Item."Manufacturer Code";
            "Vendor No" := Item."Vendor No.";
            "Vendor Item No" := Item."Vendor Item No.";

            Insert;
        end
    end;


    procedure IFItemSalesLinesExit(SalesInvHead: Record "Sales Invoice Header"): Boolean
    var
        ItemSalesHistory: Record "CBR Item Sales History";
    begin
        ItemSalesHistory.Reset;
        ItemSalesHistory.SetRange("Invoice No", SalesInvHead."No.");
        if ItemSalesHistory.Count > 0 then
            exit(true)
        else
            exit(false)
    end;


    procedure AutoUpdateItemSalesLines(SalesInvLine: Record "Sales Invoice Line")
    var
        SalesInvHeader: Record "Sales Invoice Header";
    begin
        with SalesInvLine do begin
            SalesInvHeader.Get(SalesInvLine."Document No.");
            CreateLines(SalesInvHeader, SalesInvLine);
        end;
    end;
}

