tableextension 50005 CBRExtendGenJournalLine extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBR Account Name"; Text[50])
        {
            Caption = 'Account Name';
            DataClassification = CustomerContent;
            Description = 'CBR_SS';
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                GLRecLoc: Record "G/L Account";
                CustRecLo: Record Customer;
                VendRecLoc: Record Vendor;
                BankAccLoc: Record "Bank Account";
            begin
                IF "Account No." <> xRec."Account No." THEN BEGIN
                    "CBR Account Name" := '';//CBR_SS
                    CASE Rec."Account Type" OF
                        Rec."Account Type"::"G/L Account":
                            BEGIN
                                GLRecLoc.GET(Rec."Account No.");
                                Rec."CBR Account Name" := GLRecLoc.Name;
                            END;
                        Rec."Account Type"::Customer:
                            BEGIN
                                CustRecLo.GET(Rec."Account No.");
                                Rec."CBR Account Name" := CustRecLo.Name;
                            END;
                        Rec."Account Type"::Vendor:
                            BEGIN
                                VendRecLoc.GET(Rec."Account No.");
                                Rec."CBR Account Name" := VendRecLoc.Name;
                            END;
                        Rec."Account Type"::"Bank Account":
                            BEGIN
                                BankAccLoc.GET(Rec."Account No.");
                                Rec."CBR Account Name" := BankAccLoc.Name;
                            END;
                    end;
                end;
            end;
        }
    }

    var
        myInt: Integer;
}