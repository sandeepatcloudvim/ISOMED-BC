pageextension 50050 CBRExtendSalesPrices extends "Sales Prices"
{
    layout
    {
        addafter(SalesCodeFilterCtrl)
        {
            field(CustomerFilter; CustomerFilter)
            {
                CaptionML = ENU = 'CustomerFilter';
                ApplicationArea = all;
                TableRelation = Customer;
                trigger OnValidate()
                begin
                    //CBR_SS++
                    // IF CustomerFilter <> '' THEN BEGIN
                    //     SETRANGE("Sales Code", CustomerFilter);
                    //     CurrPage.UPDATE(FALSE);
                    // END
                    // ELSE
                    //     SalesCodeFilterOnAfterValidate;
                    //CBR_SS++
                end;
            }
        }
    }

    actions
    {
        addafter(ClearFilter)
        {
            action(CopyCustomerPrices)
            {
                Caption = 'Copy Customer Prices';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedIsBig = true;
                Image = Copy;
                Visible = NOT IsLookupMode;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    //CBR_SS 16/11/2018++
                    CopyPrices;
                    CurrPage.UPDATE;
                    //CBR_SS 16/11/2018--
                end;
            }
        }
    }
    PROCEDURE CopyPrices();
    VAR
        Customer: Record Customer;
        SalesPrice: Record "Sales Price";
        SelectedSalesPrice: Record "Sales Price";
        SalesPrices: Page "Sales Prices";
        CopyToCustomerNo: Code[20];
    BEGIN
        //CBR_SS 16/11/2018++

        // IF SalesTypeFilter <> SalesTypeFilter::Customer THEN
        //     ERROR(IncorrectSalesTypeToCopyPricesErr);
        // Customer.SETFILTER("No.", SalesCodeFilter);
        // IF Customer.COUNT <> 1 THEN
        //     ERROR(MultipleCustomersSelectedErr);
        // CopyToCustomerNo := COPYSTR(SalesCodeFilter, 1, MAXSTRLEN(CopyToCustomerNo));
        // SalesPrice.SETRANGE("Sales Type", SalesPrice."Sales Type"::Customer);
        // IF CustomerFilter <> '' THEN
        //     SalesPrice.SETFILTER("Sales Code", '%1', CustomerFilter)
        // ELSE
        //     SalesPrice.SETFILTER("Sales Code", '<>%1', SalesCodeFilter);
        // SalesPrices.LOOKUPMODE(TRUE);
        // SalesPrices.SETTABLEVIEW(SalesPrice);
        // IF SalesPrices.RUNMODAL = ACTION::LookupOK THEN BEGIN
        //     SalesPrices.GetSelectionFilter(SelectedSalesPrice);
        //     CopySalesPriceToCustomersSalesPrice(SelectedSalesPrice, CopyToCustomerNo);
        // END;
        //CBR_SS 16/11/2018--
    END;

    // PROCEDURE GetSelectionFilter(VAR SalesPrice: Record "Sales Price");
    // BEGIN
    //     //CBR_SS 16/11/2018++
    //     CurrPage.SETSELECTIONFILTER(SalesPrice);
    //     //CBR_SS 16/11/2018--
    // END;

    var
        myInt: Integer;
        IsLookupMode: Boolean;
        IncorrectSalesTypeToCopyPricesErr: Label 'ENU=To copy sales prices, The Sales Type Filter field must contain Customer.;ESM=Para copiar precios de venta, el campo Filtro tipo ventas debe Cliente.;FRC=Pour copier les prix de vente, le champ Filtre type vente doit contenir un client.;ENC=To copy sales prices, The Sales Type Filter field must contain Customer.';
        MultipleCustomersSelectedErr: Label 'ENU=More than one customer uses these sales prices. To copy prices, the Sales Code Filter field must contain one customer only.;ESM=M s de un cliente usa estos precios de venta. Para copiar precios, el campo Filtro c¢d. ventas debe contener un solo cliente.;FRC=Plus d''un client utilise ces prix de vente. Pour copier des prix, le champ Filtre code vente doit contenir un client uniquement.;ENC=More than one customer uses these sales prices. To copy prices, the Sales Code Filter field must contain one customer only.';
        CustomerFilter: Text;
        FilterBuffer: Text;

    trigger OnClosePage()
    begin
        CustomerFilter := '';
    end;
}