codeunit 50001 CBRCodeunitSubscribers
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Correct Posted Sales Invoice", 'OnBeforeSalesHeaderInsert', '', false, false)]
    procedure OnRunOnBefSalesInsertEvent(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; CancellingOnly: Boolean)
    var
        ExtendCPSI: Codeunit 50002;
    begin
        ExtendCPSI.UpdateShipInformation(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnAfterCopySalesDocument', '', false, false)]
    procedure CopySalesDocOnAfterCopySalesDoc(FromDocumentType: Option; FromDocumentNo: Code[20]; var ToSalesHeader: Record "Sales Header"; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer; IncludeHeader: Boolean; RecalculateLines: Boolean; MoveNegLines: Boolean)
    var
        ExtendCPSI: Codeunit 50002;
    begin
        ExtendCPSI.UpdateShipInformation(ToSalesHeader);
    end;
}