tableextension 50000 CBRExtendCustomer extends Customer
{
    fields
    {
        field(50001; CBRDefaultPONo; Text[25])
        {
            Caption = 'DefaultPONo';
            DataClassification = CustomerContent;
        }
    }


    procedure CBRSetNextCustNo(NameVariable: Text)
    var
        NextNo: Code[20];
        RecCust: Record Customer;
        NameInitials: Code[20];
        RecCust1: Record Customer;
        IntVar: Integer;
    begin
        NameInitials := NameVariable;
        NameInitials := DELCHR(NameInitials, '=', '1234567890');
        NameInitials := DELCHR(NameInitials, '=', TextDelete);
        NameInitials := 'ISO' + COPYSTR(NameInitials, 1, 1);

        RecCust.RESET;
        RecCust.SETFILTER("No.", '%1', '@' + NameInitials + '*');
        IF RecCust.FINDLAST THEN
            NextNo := INCSTR(RecCust."No.")
        ELSE
            NextNo := NameInitials + '1000';
        NextCustNo := NextNo;
        FromContact := TRUE;

    end;

    trigger OnBeforeInsert()
    begin
        //CBR_SS_05052018++
        IF FromContact THEN
            "No." := NextCustNo;
        //CBR_SS_0505201--
    end;

    var
        NextCustNo: Code[20];
        FromContact: Boolean;
        TextDelete: Label '~`!@#$%^&*()_-+=/*.,<.>?;:""{}[]|\''';

}