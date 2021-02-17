page 50021 "Management Dashboard"
{
    // CBR_SS : 28032018 : New Page Created

    Caption = 'Management Dashboard';

    layout
    {
        area(content)
        {
            group("Accounts Receivable")
            {
                Caption = 'Accounts Receivable';
                //The GridLayout property is only supported on controls of type Grid
                //GridLayout = Rows;
                grid(Control1000000009)
                {
                    GridLayout = Rows;
                    ShowCaption = false;

                    group(Control1000000012)
                    {
                        ShowCaption = false;
                        field("0 to 30 Days"; Amt30D[1])
                        {
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Customer('30D');
                            end;
                        }
                        field("31 to 60 Days"; Amt60D[1])
                        {
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Customer('60D');
                            end;
                        }
                        field("61 to 90 Days"; Amt90D[1])
                        {
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Customer('90D');
                            end;
                        }
                        field("Over 90 Days"; AmtMoreThan90D[1])
                        {
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Customer('MoreThan90D');
                            end;
                        }
                        field("Total "; Amt30D[1] + Amt60D[1] + Amt90D[1] + AmtMoreThan90D[1])
                        {
                            DrillDown = true;
                            MultiLine = true;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group("Account Payable")
            {
                Caption = 'Accounts Payable';
                grid(Control1000000015)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1000000013)
                    {
                        ShowCaption = false;
                        field("0 to 30 Day"; -Amt30D[2])
                        {
                            Caption = '0 to 30 Days';
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            StyleExpr = True;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Vendor('30D');
                            end;
                        }
                        field("31 to 60 Day"; -Amt60D[2])
                        {
                            Caption = '31 to 60 Days';
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Vendor('60D');
                            end;
                        }
                        field("61 to 90 Day"; -Amt90D[2])
                        {
                            Caption = '61 to 90 Days';
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Vendor('90D');
                            end;
                        }
                        field("Over 90 Day"; -AmtMoreThan90D[2])
                        {
                            Caption = 'Over 90 Days';
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnDrillDown()
                            begin
                                OpenOverdueInvoicePage_Vendor('MoreThan90D');
                            end;
                        }
                        field(Total; -(Amt30D[2] + Amt60D[2] + Amt90D[2] + AmtMoreThan90D[2]))
                        {
                            Caption = 'Total';
                            DrillDown = true;
                            MultiLine = true;
                            ApplicationArea = All;
                        }
                    }
                }
            }
            group(Inventory)
            {
                grid(Control1000000016)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1000000017)
                    {
                        ShowCaption = false;
                        field("Total Inventory"; TotalInv)
                        {
                            Caption = 'Total Inventory Qty';
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            Visible = true;
                            ApplicationArea = All;
                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                PAGE.RunModal(38);
                            end;
                        }
                        field("Total Inventory Cost"; TotalInvCost)
                        {
                            Caption = 'Total Inventory Value';
                            DrillDown = true;
                            Editable = false;
                            MultiLine = true;
                            ApplicationArea = All;
                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                PAGE.RunModal(5802);
                            end;
                        }
                    }
                }
            }
            group(Control1000000008)
            {
                ShowCaption = false;

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CalculateInvDueAmount;
        CalculateInventoryAndCost;
    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DateVar: array[5] of Date;
        Startdate: Date;
        Enddate: Date;
        NotDue: Text;
        Amt30D: array[2] of Decimal;
        Amt60D: array[2] of Decimal;
        Amt90D: array[2] of Decimal;
        AmtMoreThan90D: array[2] of Decimal;
        CLE: Record "Cust. Ledger Entry";
        VLE: Record "Vendor Ledger Entry";
        ValueEntry: Record "Value Entry";
        TotalInvCost: Decimal;
        TotalInv: Decimal;
        RecItem: Record Item;
        ILE: Record "Item Ledger Entry";
        CurrentAmt: Decimal;
        CurrentVendAmt: Decimal;
        TempBuffer: Record "Item Location Variant Buffer";

    local procedure CalculateInvDueAmount()
    begin
        Startdate := Today;
        Enddate := DMY2Date(31, 12, 9999);

        //Account Receivable.........>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        Amt30D[1] := 0;
        Amt60D[1] := 0;
        Amt90D[1] := 0;
        AmtMoreThan90D[1] := 0;

        CurrentAmt := 0;
        CLE.Reset;
        CLE.SetCurrentKey("Document Type", "Due Date");
        CLE.SetFilter("Due Date", '>=%1', Startdate);
        if CLE.FindSet then begin
            repeat
                CLE.CalcFields("Remaining Amt. (LCY)");
                CurrentAmt := CurrentAmt + CLE."Remaining Amt. (LCY)"
            until CLE.Next = 0;
        end;

        DateVar[2] := 0D;
        DateVar[2] := CalcDate('<-30D>', Startdate);
        CLE.Reset;
        CLE.SetCurrentKey("Document Type", "Due Date");
        //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
        CLE.SetRange("Due Date", DateVar[2], Startdate - 1);
        if CLE.FindSet then begin
            repeat
                CLE.CalcFields("Remaining Amt. (LCY)");
                Amt30D[1] := Amt30D[1] + CLE."Remaining Amt. (LCY)"
            until CLE.Next = 0;
            Amt30D[1] := Amt30D[1] + CurrentAmt;
        end;

        //30 to 60 days
        DateVar[3] := 0D;
        DateVar[3] := CalcDate('<-60D>', Startdate);
        CLE.Reset;
        CLE.SetCurrentKey("Document Type", "Due Date");
        //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
        CLE.SetRange("Due Date", DateVar[3], DateVar[2] - 1);
        if CLE.FindSet then begin

            repeat
                CLE.CalcFields("Remaining Amt. (LCY)");
                Amt60D[1] := Amt60D[1] + CLE."Remaining Amt. (LCY)"
            until CLE.Next = 0;
        end;

        // 60 to 90 days
        DateVar[4] := 0D;
        DateVar[4] := CalcDate('<-90D>', Startdate);
        CLE.Reset;
        CLE.SetCurrentKey("Document Type", "Due Date");
        //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
        CLE.SetRange("Due Date", DateVar[4], DateVar[3] - 1);
        if CLE.FindSet then begin

            repeat
                CLE.CalcFields("Remaining Amt. (LCY)");
                Amt90D[1] := Amt90D[1] + CLE."Remaining Amt. (LCY)"
            until CLE.Next = 0;
        end;

        //
        // Over 90 days
        DateVar[5] := 0D;
        DateVar[5] := CalcDate('<-90D>', Startdate);

        CLE.Reset;
        CLE.SetCurrentKey("Document Type", "Due Date");
        //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
        CLE.SetFilter("Due Date", '..%1', DateVar[5] - 1);
        if CLE.FindSet then begin
            repeat
                CLE.CalcFields("Remaining Amt. (LCY)");
                AmtMoreThan90D[1] := AmtMoreThan90D[1] + CLE."Remaining Amt. (LCY)"
            until CLE.Next = 0;
        end;
        //Account Receivable.....................................<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        //Account Payable.......................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        Amt30D[2] := 0;
        Amt60D[2] := 0;
        Amt90D[2] := 0;
        AmtMoreThan90D[2] := 0;


        CurrentVendAmt := 0;
        VLE.Reset;
        VLE.SetCurrentKey("Document Type", "Due Date");
        VLE.SetFilter("Due Date", '>=%1', Startdate);
        if VLE.FindSet then begin
            repeat
                VLE.CalcFields("Remaining Amt. (LCY)");
                CurrentVendAmt := CurrentVendAmt + VLE."Remaining Amt. (LCY)";
            until VLE.Next = 0;
        end;

        DateVar[2] := 0D;
        DateVar[2] := CalcDate('<-30D>', Startdate);
        VLE.Reset;
        VLE.SetCurrentKey("Document Type", "Due Date");
        VLE.SetRange("Due Date", DateVar[2], Startdate - 1);
        if VLE.FindSet then begin
            repeat
                VLE.CalcFields("Remaining Amt. (LCY)");
                Amt30D[2] := Amt30D[2] + VLE."Remaining Amt. (LCY)";
            until VLE.Next = 0;
            Amt30D[2] := Amt30D[2] + CurrentVendAmt;
        end;

        //30 to 60 days
        DateVar[3] := 0D;
        DateVar[3] := CalcDate('<-60D>', Startdate);
        VLE.Reset;
        VLE.SetCurrentKey("Document Type", "Due Date");
        //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
        VLE.SetRange("Due Date", DateVar[3], DateVar[2] - 1);
        if VLE.FindSet then begin

            repeat
                VLE.CalcFields("Remaining Amt. (LCY)");
                Amt60D[2] := Amt60D[2] + VLE."Remaining Amt. (LCY)"
            until VLE.Next = 0;
        end;

        // 60 to 90 days
        DateVar[4] := 0D;
        DateVar[4] := CalcDate('<-90D>', Startdate);
        VLE.Reset;
        VLE.SetCurrentKey("Document Type", "Due Date");
        //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
        VLE.SetRange("Due Date", DateVar[4], DateVar[3] - 1);
        if VLE.FindSet then begin

            repeat
                VLE.CalcFields("Remaining Amt. (LCY)");
                Amt90D[2] := Amt90D[2] + VLE."Remaining Amt. (LCY)"
            until VLE.Next = 0;
        end;

        //
        // Over 90 days
        DateVar[5] := 0D;
        DateVar[5] := CalcDate('<-90D>', Startdate);

        VLE.Reset;
        VLE.SetCurrentKey("Document Type", "Due Date");
        //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
        VLE.SetFilter("Due Date", '..%1', DateVar[5] - 1);
        if VLE.FindSet then begin
            repeat
                VLE.CalcFields("Remaining Amt. (LCY)");
                AmtMoreThan90D[2] := AmtMoreThan90D[2] + VLE."Remaining Amt. (LCY)"
            until VLE.Next = 0;
        end;
        //Account Payable.......................................<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    end;

    local procedure OpenOverdueInvoicePage_Customer(Days: Text)
    var
        OverDueInvoices: Page "Customer Ledger Entries";
    begin
        Startdate := Today;
        Enddate := DMY2Date(31, 12, 9999);

        //Account Receivable....................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        case Days of
            '30D':
                begin
                    DateVar[2] := 0D;
                    DateVar[2] := CalcDate('<-30D>', Startdate);
                    CLE.Reset;
                    CLE.SetRange("Due Date", DateVar[2], Startdate - 1);
                    //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
                    if CLE.FindSet then;
                end;
            '60D':
                begin
                    DateVar[3] := 0D;
                    DateVar[3] := CalcDate('<-60D>', Startdate);
                    CLE.Reset;
                    CLE.SetRange("Due Date", DateVar[3], DateVar[2] - 1);
                    //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
                    if CLE.FindSet then;
                end;
            '90D':
                begin
                    DateVar[4] := 0D;
                    DateVar[4] := CalcDate('<-90D>', Startdate);
                    CLE.Reset;
                    CLE.SetRange("Due Date", DateVar[4], DateVar[3] - 1);
                    //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
                    if CLE.FindSet then;
                end;
            'MoreThan90D':
                begin
                    DateVar[5] := 0D;
                    DateVar[5] := CalcDate('<-90D>', Startdate);

                    CLE.Reset;
                    CLE.SetFilter("Due Date", '..%1', DateVar[5]);
                    //CLE.SETRANGE("Document Type",CLE."Document Type"::Invoice);
                    if CLE.FindSet then;
                end;
        end;
        PAGE.RunModal(25, CLE);
        //Account Receivable....................................<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    end;

    local procedure OpenOverdueInvoicePage_Vendor(Days: Text)
    var
        OverDueInvoices: Page "Vendor Ledger Entries";
    begin
        Startdate := Today;
        Enddate := DMY2Date(31, 12, 9999);

        //Account Payable....................................>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        case Days of
            '30D':
                begin
                    DateVar[2] := 0D;
                    DateVar[2] := CalcDate('<-30D>', Startdate);
                    VLE.Reset;
                    VLE.SetCurrentKey("Document Type", "Due Date");
                    //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
                    VLE.SetRange("Due Date", DateVar[2], Startdate - 1);
                    if VLE.FindSet then;
                end;
            '60D':
                begin
                    DateVar[3] := 0D;
                    DateVar[3] := CalcDate('<-60D>', Startdate);
                    VLE.Reset;
                    VLE.SetCurrentKey("Document Type", "Due Date");
                    //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
                    VLE.SetRange("Due Date", DateVar[3], DateVar[2] - 1);
                    if VLE.FindSet then;
                end;
            '90D':
                begin
                    DateVar[4] := 0D;
                    DateVar[4] := CalcDate('<-90D>', Startdate);
                    VLE.Reset;
                    VLE.SetCurrentKey("Document Type", "Due Date");
                    //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
                    VLE.SetRange("Due Date", DateVar[4], DateVar[3] - 1);
                    if VLE.FindSet then;
                end;
            'MoreThan90D':
                begin
                    DateVar[5] := 0D;
                    DateVar[5] := CalcDate('<-90D>', Startdate);

                    VLE.Reset;
                    VLE.SetCurrentKey("Document Type", "Due Date");
                    //VLE.SETRANGE("Document Type",VLE."Document Type"::Invoice);
                    VLE.SetFilter("Due Date", '..%1', DateVar[5]);
                    if VLE.FindSet then;
                end;
        end;
        PAGE.RunModal(29, VLE);
        //Account Payable....................................<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    end;

    local procedure CalculateInventoryAndCost()
    begin
        TotalInvCost := 0;
        TotalInv := 0;

        // ValueEntry.RESET;
        // IF ValueEntry.FINDSET THEN
        // REPEAT
        //  TotalInvCost := TotalInvCost + ValueEntry."Cost Amount (Actual)";
        // UNTIL  ValueEntry.NEXT =0;

        ILE.Reset;
        if ILE.Find('-') then
            repeat
                ILE.CalcFields("Cost Amount (Actual)");
                ILE.CalcFields(ILE."Cost Amount (Expected)");
                TotalInvCost := TotalInvCost + ILE."Cost Amount (Actual)" + ILE."Cost Amount (Expected)";
                TotalInv := TotalInv + ILE.Quantity;
            until ILE.Next = 0;



        // RecItem.RESET;
        // IF RecItem.FINDSET THEN
        // REPEAT
        //    RecItem.CALCFIELDS(Inventory);
        //    TotalInv := TotalInv+ RecItem.Inventory;
        // UNTIL RecItem.NEXT =0;
    end;
}

