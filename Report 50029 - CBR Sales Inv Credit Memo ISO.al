report 50029 "Sales Inv Credit Memo ISO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesInvCreditMemoISO.rdl';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
            RequestFilterFields = "Posting Date";
            column(CustDateFilter; CustDateFilter)
            {
            }
            column(EntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate_CustLedgerEntry; "Cust. Ledger Entry"."Posting Date")
            {
            }
            column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
            {
            }
            column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
            {
            }
            column(Description_CustLedgerEntry; "Cust. Ledger Entry".Description)
            {
            }
            column(CurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Currency Code")
            {
            }
            column(Amount_CustLedgerEntry; "Cust. Ledger Entry".Amount)
            {
            }
            column(RemainingAmount_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amount")
            {
            }
            column(OriginalAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Original Amt. (LCY)")
            {
            }
            column(RemainingAmtLCY_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Amt. (LCY)")
            {
            }
            column(AmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Amount (LCY)")
            {
            }
            column(SalesLCY_CustLedgerEntry; "Cust. Ledger Entry"."Sales (LCY)")
            {
            }
            column(ProfitLCY_CustLedgerEntry; "Cust. Ledger Entry"."Profit (LCY)")
            {
            }
            column(InvDiscountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Inv. Discount (LCY)")
            {
            }
            column(SelltoCustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Sell-to Customer No.")
            {
            }
            column(CustomerPostingGroup_CustLedgerEntry; "Cust. Ledger Entry"."Customer Posting Group")
            {
            }
            column(GlobalDimension1Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_CustLedgerEntry; "Cust. Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(SalespersonCode_CustLedgerEntry; "Cust. Ledger Entry"."Salesperson Code")
            {
            }
            column(UserID_CustLedgerEntry; "Cust. Ledger Entry"."User ID")
            {
            }
            column(SourceCode_CustLedgerEntry; "Cust. Ledger Entry"."Source Code")
            {
            }
            column(OnHold_CustLedgerEntry; "Cust. Ledger Entry"."On Hold")
            {
            }
            column(AppliestoDocType_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to Doc. Type")
            {
            }
            column(AppliestoDocNo_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to Doc. No.")
            {
            }
            column(Open_CustLedgerEntry; "Cust. Ledger Entry".Open)
            {
            }
            column(DueDate_CustLedgerEntry; "Cust. Ledger Entry"."Due Date")
            {
            }
            column(PmtDiscountDate_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Discount Date")
            {
            }
            column(OriginalPmtDiscPossible_CustLedgerEntry; "Cust. Ledger Entry"."Original Pmt. Disc. Possible")
            {
            }
            column(PmtDiscGivenLCY_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Disc. Given (LCY)")
            {
            }
            column(Positive_CustLedgerEntry; "Cust. Ledger Entry".Positive)
            {
            }
            column(ClosedbyEntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Entry No.")
            {
            }
            column(ClosedatDate_CustLedgerEntry; "Cust. Ledger Entry"."Closed at Date")
            {
            }
            column(ClosedbyAmount_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Amount")
            {
            }
            column(AppliestoID_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to ID")
            {
            }
            column(JournalBatchName_CustLedgerEntry; "Cust. Ledger Entry"."Journal Batch Name")
            {
            }
            column(ReasonCode_CustLedgerEntry; "Cust. Ledger Entry"."Reason Code")
            {
            }
            column(BalAccountType_CustLedgerEntry; "Cust. Ledger Entry"."Bal. Account Type")
            {
            }
            column(BalAccountNo_CustLedgerEntry; "Cust. Ledger Entry"."Bal. Account No.")
            {
            }
            column(TransactionNo_CustLedgerEntry; "Cust. Ledger Entry"."Transaction No.")
            {
            }
            column(ClosedbyAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Amount (LCY)")
            {
            }
            column(DebitAmount_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount")
            {
            }
            column(DebitAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount (LCY)")
            {
            }
            column(CreditAmountLCY_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount (LCY)")
            {
            }
            column(DocumentDate_CustLedgerEntry; "Cust. Ledger Entry"."Document Date")
            {
            }
            column(ExternalDocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."External Document No.")
            {
            }
            column(CalculateInterest_CustLedgerEntry; "Cust. Ledger Entry"."Calculate Interest")
            {
            }
            column(ClosingInterestCalculated_CustLedgerEntry; "Cust. Ledger Entry"."Closing Interest Calculated")
            {
            }
            column(NoSeries_CustLedgerEntry; "Cust. Ledger Entry"."No. Series")
            {
            }
            column(ClosedbyCurrencyCode_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Currency Code")
            {
            }
            column(ClosedbyCurrencyAmount_CustLedgerEntry; "Cust. Ledger Entry"."Closed by Currency Amount")
            {
            }
            column(AdjustedCurrencyFactor_CustLedgerEntry; "Cust. Ledger Entry"."Adjusted Currency Factor")
            {
            }
            column(OriginalCurrencyFactor_CustLedgerEntry; "Cust. Ledger Entry"."Original Currency Factor")
            {
            }
            column(OriginalAmount_CustLedgerEntry; "Cust. Ledger Entry"."Original Amount")
            {
            }
            column(DateFilter_CustLedgerEntry; "Cust. Ledger Entry"."Date Filter")
            {
            }
            column(RemainingPmtDiscPossible_CustLedgerEntry; "Cust. Ledger Entry"."Remaining Pmt. Disc. Possible")
            {
            }
            column(PmtDiscToleranceDate_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Disc. Tolerance Date")
            {
            }
            column(MaxPaymentTolerance_CustLedgerEntry; "Cust. Ledger Entry"."Max. Payment Tolerance")
            {
            }
            column(LastIssuedReminderLevel_CustLedgerEntry; "Cust. Ledger Entry"."Last Issued Reminder Level")
            {
            }
            column(AcceptedPaymentTolerance_CustLedgerEntry; "Cust. Ledger Entry"."Accepted Payment Tolerance")
            {
            }
            column(AcceptedPmtDiscTolerance_CustLedgerEntry; "Cust. Ledger Entry"."Accepted Pmt. Disc. Tolerance")
            {
            }
            column(PmtToleranceLCY_CustLedgerEntry; "Cust. Ledger Entry"."Pmt. Tolerance (LCY)")
            {
            }
            column(AmounttoApply_CustLedgerEntry; "Cust. Ledger Entry"."Amount to Apply")
            {
            }
            column(ICPartnerCode_CustLedgerEntry; "Cust. Ledger Entry"."IC Partner Code")
            {
            }
            column(ApplyingEntry_CustLedgerEntry; "Cust. Ledger Entry"."Applying Entry")
            {
            }
            column(Reversed_CustLedgerEntry; "Cust. Ledger Entry".Reversed)
            {
            }
            column(ReversedbyEntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Reversed Entry No.")
            {
            }
            column(Prepayment_CustLedgerEntry; "Cust. Ledger Entry".Prepayment)
            {
            }
            column(PaymentMethodCode_CustLedgerEntry; "Cust. Ledger Entry"."Payment Method Code")
            {
            }
            column(AppliestoExtDocNo_CustLedgerEntry; "Cust. Ledger Entry"."Applies-to Ext. Doc. No.")
            {
            }
            column(RecipientBankAccount_CustLedgerEntry; "Cust. Ledger Entry"."Recipient Bank Account")
            {
            }
            column(MessagetoRecipient_CustLedgerEntry; "Cust. Ledger Entry"."Message to Recipient")
            {
            }
            column(ExportedtoPaymentFile_CustLedgerEntry; "Cust. Ledger Entry"."Exported to Payment File")
            {
            }
            column(DimensionSetID_CustLedgerEntry; "Cust. Ledger Entry"."Dimension Set ID")
            {
            }
            column(DirectDebitMandateID_CustLedgerEntry; "Cust. Ledger Entry"."Direct Debit Mandate ID")
            {
            }
            column(StateValue; StateValue)
            {
            }
            column(CityValues; CityValue)
            {
            }
            column(NameValue; recCustomer.Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if recCustomer.Get("Cust. Ledger Entry"."Customer No.") then;
                Clear(StateValue);
                Clear(CityValue);

                if recSalesInvHeader.Get("Cust. Ledger Entry"."Document No.") then begin
                    CityValue := recSalesInvHeader."Ship-to City";
                    StateValue := recSalesInvHeader."Ship-to County";
                end;
                if recSalesCreditMemo.Get("Cust. Ledger Entry"."Document No.") then begin
                    CityValue := recSalesCreditMemo."Ship-to City";
                    StateValue := recSalesCreditMemo."Ship-to County";
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = false;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CustDateFilter := "Cust. Ledger Entry".GetFilter("Posting Date");
    end;

    var
        recSalesInvHeader: Record "Sales Invoice Header";
        recSalesCreditMemo: Record "Sales Cr.Memo Header";
        StateValue: Text[30];
        CityValue: Text[30];
        recCustomer: Record Customer;
        CustDateFilter: Text;
}

