tableextension 50015 CBRExtendSalesPrice extends "Sales Price"
{

    fields
    {
        // Add changes to table fields here
    }
    procedure CopySalesPriceToCustomersSalesPrice(SalesPrice: Record "Sales Price"; CustNo: Code[20])
    var
        NewSalesPrice: Record "Sales Price";
    begin
        //CBR_SS 16/11/2018++
        IF SalesPrice.FINDSET THEN
            REPEAT
                NewSalesPrice := SalesPrice;
                NewSalesPrice."Sales Type" := NewSalesPrice."Sales Type"::Customer;
                NewSalesPrice."Sales Code" := CustNo;
                IF NewSalesPrice.INSERT THEN;
            UNTIL SalesPrice.NEXT = 0;
        //CBR_SS 16/11/2018--
    end;

    var
        myInt: Integer;
}