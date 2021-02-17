report 50010 "BackOrder Fullfilment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './BackOrderFullfilment.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.";
            column(No_PurchaseHeader; "Purchase Header"."No.")
            {
            }
            column(OrderDate_PurchaseHeader; "Purchase Header"."Order Date")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(Type_PurchaseLine; "Purchase Line".Type)
                {
                }
                column(DocumentNo_PurchaseLine; "Purchase Line"."Document No.")
                {
                }
                column(No_PurchaseLine; "Purchase Line"."No.")
                {
                }
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = FIELD("No.");
                    column(No_Item; Item."No.")
                    {
                    }
                    column(QtyOnSalesOrder; Item."Qty. on Sales Order")
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "No." = FIELD("No.");
                        DataItemTableView = WHERE(Type = FILTER(Item));
                        column(DocumentNo; "Sales Line"."Document No.")
                        {
                        }
                        column(SellToCustomerNo; "Sales Line"."Sell-to Customer No.")
                        {
                        }
                        column(LocationCode; "Sales Line"."Location Code")
                        {
                        }
                        column(ShipmentDate; "Sales Line"."Shipment Date")
                        {
                        }
                        column(Description; "Sales Line".Description)
                        {
                        }
                        column(UOM; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(OutstandingQuantity; "Sales Line"."Outstanding Quantity")
                        {
                        }
                        column(Amount; "Sales Line".Amount)
                        {
                        }
                    }
                }
            }
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
}

