report 50041 "CBR Ship-To Address Listing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ShipToAddressListing.rdl';
    Caption = 'Ship-To Address Listing';

    dataset
    {
        dataitem(Customer; Customer)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            // column(CurrReport_PAGENO; CurrReport.PageNo)
            // {
            // }
            column(USERID; UserId)
            {
            }
            column(TABLECAPTION__________FilterString; TableCaption + ': ' + FilterString)
            {
            }
            column(FilterString; FilterString)
            {
            }
            column(Ship_to_Address__TABLECAPTION__________FilterString2; "Ship-to Address".TableCaption + ': ' + FilterString2)
            {
            }
            column(FilterString2; FilterString2)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_Contact; Contact)
            {
            }
            column(Customer__Phone_No__; "Phone No.")
            {
            }
            column(GLN_cust; Customer.GLN)
            {
            }
            column(Ship_To_Address_ListingCaption; Ship_To_Address_ListingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; Customer__No__CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Ship_to_Address_ContactCaption; "Ship-to Address".FieldCaption(Contact))
            {
            }
            column(Ship_to_Address__UPS_Zone_Caption; "Ship-to Address".FieldCaption("UPS Zone"))
            {
            }
            column(Ship_to_Address__Shipment_Method_Code_Caption; Ship_to_Address__Shipment_Method_Code_CaptionLbl)
            {
            }
            column(Ship_to_Address_CodeCaption; Ship_to_Address_CodeCaptionLbl)
            {
            }
            column(ShiptoAddr_1_Caption; ShiptoAddr_1_CaptionLbl)
            {
            }
            column(Ship_to_Address__Phone_No__Caption; "Ship-to Address".FieldCaption("Phone No."))
            {
            }
            column(Ship_to_Address__Tax_Area_Code_Caption; Ship_to_Address__Tax_Area_Code_CaptionLbl)
            {
            }
            dataitem("Ship-to Address"; "Ship-to Address")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Code);
                RequestFilterFields = "Code", "Shipment Method Code";
                column(Customer__No___Control24; Customer."No.")
                {
                }
                column(Customer_Name_Control25; Customer.Name)
                {
                }
                column(Ship_to_Address_Code; Code)
                {
                }
                column(ShiptoAddr_1_; ShiptoAddr[1])
                {
                }
                column(Ship_to_Address_Contact; Contact)
                {
                }
                column(Ship_to_Address__Tax_Area_Code_; "Tax Area Code")
                {
                }
                column(Ship_to_Address__UPS_Zone_; "UPS Zone")
                {
                }
                column(Ship_to_Address__Shipment_Method_Code_; "Shipment Method Code")
                {
                }
                column(ShiptoAddr_2_; ShiptoAddr[2])
                {
                }
                column(Ship_to_Address__Phone_No__; "Phone No.")
                {
                }
                column(TaxArea_Description; TaxArea.Description)
                {
                }
                column(GLN_ship; "Ship-to Address".GLN)
                {
                }
                column(member_id; "Ship-to Address"."CBR Member ID")
                {
                }
                column(ShipmentMethod_Description; ShipmentMethod.Description)
                {
                }
                column(ShiptoAddr_3_; ShiptoAddr[3])
                {
                }
                column(ShiptoAddr_4_; ShiptoAddr[4])
                {
                }
                column(ShiptoAddr_5_; ShiptoAddr[5])
                {
                }
                column(ShiptoAddr_6_; ShiptoAddr[6])
                {
                }
                column(ShiptoAddr_7_; ShiptoAddr[7])
                {
                }
                column(ShiptoAddr_8_; ShiptoAddr[8])
                {
                }
                column(Ship_to_Address_Customer_No_; "Customer No.")
                {
                }
                column(continued_Caption; continued_CaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    FormatAddress.FormatAddr(
                      ShiptoAddr, Name, "Name 2", Contact, Address, "Address 2", City, "Post Code", County, "Country/Region Code");
                    if not ShipmentMethod.Get("Shipment Method Code") then
                        ShipmentMethod.Description := '';
                    if not TaxArea.Get("Tax Area Code") then
                        TaxArea.Description := '';
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        FilterString := Customer.GetFilters;
        FilterString2 := "Ship-to Address".GetFilters;
    end;

    var
        CompanyInformation: Record "Company Information";
        ShiptoAddr: array[8] of Text[50];
        ShipmentMethod: Record "Shipment Method";
        TaxArea: Record "Tax Area";
        FormatAddress: Codeunit "Format Address";
        FilterString: Text;
        FilterString2: Text;
        Ship_To_Address_ListingCaptionLbl: Label 'Ship-To Address Listing';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Customer__No__CaptionLbl: Label 'Customer No.';
        Customer_NameCaptionLbl: Label 'Name';
        Ship_to_Address__Shipment_Method_Code_CaptionLbl: Label 'Shipment Method';
        Ship_to_Address_CodeCaptionLbl: Label 'Ship-To Code';
        ShiptoAddr_1_CaptionLbl: Label 'Ship-To Name and Address';
        Ship_to_Address__Tax_Area_Code_CaptionLbl: Label 'Sales Tax Area';
        continued_CaptionLbl: Label '(continued)';
}

