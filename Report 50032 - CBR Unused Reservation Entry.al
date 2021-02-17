report 50032 "Unused Reservation Entry"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UnusedReservationEntry.rdl';

    dataset
    {
        dataitem("Reservation Entry"; "Reservation Entry")
        {
            column(EntryNo_ReservationEntry; "Reservation Entry"."Entry No.")
            {
            }
            column(ItemNo_ReservationEntry; "Reservation Entry"."Item No.")
            {
            }
            column(LocationCode_ReservationEntry; "Reservation Entry"."Location Code")
            {
            }
            column(QuantityBase_ReservationEntry; "Reservation Entry"."Quantity (Base)")
            {
            }
            column(ReservationStatus_ReservationEntry; "Reservation Entry"."Reservation Status")
            {
            }
            column(Description_ReservationEntry; "Reservation Entry".Description)
            {
            }
            column(CreationDate_ReservationEntry; "Reservation Entry"."Creation Date")
            {
            }
            column(TransferredfromEntryNo_ReservationEntry; "Reservation Entry"."Transferred from Entry No.")
            {
            }
            column(SourceType_ReservationEntry; "Reservation Entry"."Source Type")
            {
            }
            column(SourceSubtype_ReservationEntry; "Reservation Entry"."Source Subtype")
            {
            }
            column(SourceID_ReservationEntry; "Reservation Entry"."Source ID")
            {
            }
            column(SourceBatchName_ReservationEntry; "Reservation Entry"."Source Batch Name")
            {
            }
            column(SourceProdOrderLine_ReservationEntry; "Reservation Entry"."Source Prod. Order Line")
            {
            }
            column(SourceRefNo_ReservationEntry; "Reservation Entry"."Source Ref. No.")
            {
            }
            column(ItemLedgerEntryNo_ReservationEntry; "Reservation Entry"."Item Ledger Entry No.")
            {
            }
            column(ExpectedReceiptDate_ReservationEntry; "Reservation Entry"."Expected Receipt Date")
            {
            }
            column(ShipmentDate_ReservationEntry; "Reservation Entry"."Shipment Date")
            {
            }
            column(SerialNo_ReservationEntry; "Reservation Entry"."Serial No.")
            {
            }
            column(CreatedBy_ReservationEntry; "Reservation Entry"."Created By")
            {
            }
            column(ChangedBy_ReservationEntry; "Reservation Entry"."Changed By")
            {
            }
            column(Positive_ReservationEntry; "Reservation Entry".Positive)
            {
            }
            column(QtyperUnitofMeasure_ReservationEntry; "Reservation Entry"."Qty. per Unit of Measure")
            {
            }
            column(Quantity_ReservationEntry; "Reservation Entry".Quantity)
            {
            }
            column(ActionMessageAdjustment_ReservationEntry; "Reservation Entry"."Action Message Adjustment")
            {
            }
            column(Binding_ReservationEntry; "Reservation Entry".Binding)
            {
            }
            column(SuppressedActionMsg_ReservationEntry; "Reservation Entry"."Suppressed Action Msg.")
            {
            }
            column(PlanningFlexibility_ReservationEntry; "Reservation Entry"."Planning Flexibility")
            {
            }
            column(AppltoItemEntry_ReservationEntry; "Reservation Entry"."Appl.-to Item Entry")
            {
            }
            column(WarrantyDate_ReservationEntry; "Reservation Entry"."Warranty Date")
            {
            }
            column(ExpirationDate_ReservationEntry; "Reservation Entry"."Expiration Date")
            {
            }
            column(QtytoHandleBase_ReservationEntry; "Reservation Entry"."Qty. to Handle (Base)")
            {
            }
            column(QtytoInvoiceBase_ReservationEntry; "Reservation Entry"."Qty. to Invoice (Base)")
            {
            }
            column(QuantityInvoicedBase_ReservationEntry; "Reservation Entry"."Quantity Invoiced (Base)")
            {
            }
            column(NewSerialNo_ReservationEntry; "Reservation Entry"."New Serial No.")
            {
            }
            column(NewLotNo_ReservationEntry; "Reservation Entry"."New Lot No.")
            {
            }
            column(DisallowCancellation_ReservationEntry; "Reservation Entry"."Disallow Cancellation")
            {
            }
            column(LotNo_ReservationEntry; "Reservation Entry"."Lot No.")
            {
            }
            column(VariantCode_ReservationEntry; "Reservation Entry"."Variant Code")
            {
            }
            column(ApplfromItemEntry_ReservationEntry; "Reservation Entry"."Appl.-from Item Entry")
            {
            }
            column(Correction_ReservationEntry; "Reservation Entry".Correction)
            {
            }
            column(NewExpirationDate_ReservationEntry; "Reservation Entry"."New Expiration Date")
            {
            }
            column(ItemTracking_ReservationEntry; "Reservation Entry"."Item Tracking")
            {
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

    var
        recSalesLine: Record "Sales Line";
}

