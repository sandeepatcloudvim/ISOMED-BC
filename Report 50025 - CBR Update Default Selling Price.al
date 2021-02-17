report 50025 "Update Default Selling Price"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                recUnitOfMeasure.Reset;
                recSalesPrice.Reset;
                recSalesPrice.SetRange("Item No.", "No.");
                recSalesPrice.SetRange("Sales Type", recSalesPrice."Sales Type"::"All Customers");
                if recSalesPrice.FindFirst then begin
                    if recUnitOfMeasure.Get(Item."No.", Item."Sales Unit of Measure") then
                        "CBR Default Selling Price" := (recSalesPrice."Unit Price" * recUnitOfMeasure."Qty. per Unit of Measure")
                end else begin
                    if recUnitOfMeasure.Get(Item."No.", Item."Base Unit of Measure") then
                        "CBR Default Selling Price" := (Item."Unit Price" * recUnitOfMeasure."Qty. per Unit of Measure")
                end;
                Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Updated the Default Selling Price');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        recSalesPrice: Record "Sales Price";
        recUnitOfMeasure: Record "Item Unit of Measure";
}

