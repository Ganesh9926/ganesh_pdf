select * from  XXSP_EWAYBILL_CHALLAN_HDRS where challan_num = 'WO/DC/23-24/22';
/
select * from xx_ewaybill_data where invoice_number = 'WO/DC/23-24/20';
/
select TYPE_OF_DOCUMENT from XX_EWAY_BILL_PART_A_HEADER;
SELECT
                lookup_code,
                description,
                tag
--            INTO
--                gstin,
--                user_name,
--                v_password
            FROM
                fnd_lookup_values
            WHERE
                    lookup_type = 'SUDHIR_GSTIN_LOGINS';
--                AND lookup_code = '24AABCS6697K3ZR';--p_seller_gstin
/                
select utl_http.request('https://gsp.adaequare.com',null,'file:/u01/oracle/DEV/19.0.0.0/owm/wallets/oracle/adaequare_wallet','Ad3QuAr#2024') 
from dual;
/
SELECT * FROM fnd_lookup_values WHERE lookup_type = 'SUDHIR_EINVOICE_AUTH';
/
SELECT * FROM fnd_lookup_values WHERE lookup_type = 'ROSTAN_EWAYBILL_AUTH';
--XXROSTAN_EWAYBILL_PKG.GET_EWAYBILL_REC_PROC
/
SELECT * FROM fnd_lookup_values WHERE lookup_type = 'ROSTAN_EWAYBILL_API_CALL';
/
select * from fnd_lookup_values where lookup_type = 'XXUOM_MAP';
/
select * from fnd_lookup_values where lookup_type = 'XX_EWAY_BILL_DOCUMENT_TYPE';
/
select * from fnd_lookup_values where lookup_type = 'XX_EWAY_BILL_SUB_SUPPLY_TYPE';
/
select * from fnd_lookup_values where lookup_type = 'XX_EWAY_SUPPLY_TYPE';
/
SELECT * FROM FND_LOOKUP_VALUES WHERE LOOKUP_TYPE = 'SUDHIR_EINVOICE_API_CALL';
/
update FND_LOOKUP_VALUES
set description = 'https://gsp.adaequare.com/test/enriched/ei/others/qr/image'
WHERE LOOKUP_TYPE = 'SUDHIR_EINVOICE_API_CALL'
and lookup_code = 6;
/
nvl((select a.description 
from fnd_lookup_values a
where a.LOOKUP_TYPE='XX_FINE_DEFINED_UOM'
and a.LOOKUP_CODE=trxl.uom_code),'NOS')                            uqc,
abs(ol.shipped_quantity) 
/
SELECT
                lookup_code,
                description,
                tag
--            INTO
--                gstin,
--                user_name,
--                v_password
            FROM
                fnd_lookup_values
            WHERE
                    lookup_type = 'SUDHIR_GSTIN_LOGINS'
                AND lookup_code = '24AABCS6697K3ZR';--p_seller_gstin;
                /
UPDATE fnd_lookup_values 
SET DESCRIPTION = 'abc123@@'
WHERE lookup_type = 'ROSTAN_EWAYBILL_API_CALL'
AND LOOKUP_CODE = 8;
/
UPDATE fnd_lookup_values 
SET DESCRIPTION = '/u01/oracle/DEV/19.0.0.0/owm/wallets/oracle/adaequare_wallet'
WHERE lookup_type = 'SUDHIR_EINVOICE_AUTH'
AND LOOKUP_CODE = 2;
/
select * from hr_operating_units where NAME = 'SPL Bangalore Operating Unit';
/
select * from hr_operating_units where organization_id = 342;
/
select * from fnd_lookup_values where lookup_type = 'XXUOM_MAP';
/
select * from fnd_lookup_values where lookup_type = 'XX_EWAY_BILL_DOCUMENT_TYPE';
/
select * from fnd_lookup_values where lookup_type = 'XX_EWAY_BILL_SUB_SUPPLY_TYPE';
/
select * from fnd_lookup_values where lookup_type = 'XX_EWAY_SUPPLY_TYPE';
/
SELECT * FROM xx_eway_bill_part_a_header ORDER BY EWAY_BILL_DATE DESC;
-- CURSOR cur_lookup IS 
 SELECT
            meaning,
            description
                             FROM
            fnd_lookup_values
                             WHERE
            lookup_type = 'ROSTAN_EWAYBILL_API_CALL'
            AND LANGUAGE = USERENV ('LANG');
/
select * from apps.XXSP_EWAYBILL_CHALLAN_HDRS where CHALLAN_NUM = 'PN/DC/23-24/30';
/ 
select * from apps.XXSP_EWAYBILL_CHALLAN_LINES where header_id = 25;
/
update XXSP_EWAYBILL_CHALLAN_LINES
set UNIT_OF_MEASURE = 'NOS'
where header_id = 21;
/
update XXSP_EWAYBILL_CHALLAN_HDRS 
set BILL_TO_CITY = 'DIST – ALWAR'
where CHALLAN_NUM = 'PN/DC/23-24/3';
/
update XXSP_EWAYBILL_CHALLAN_HDRS 
set SHIP_TO_POSTAL_CODE = 301019
where CHALLAN_NUM = 'PN/DC/23-24/3';
/
update XXSP_EWAYBILL_CHALLAN_HDRS
set OU_ORG_ID = 342--'SPL GGN Rental Division Operating Unit'
where header_id = 23;
/
select * from org_organization_definitions where organization_id = 342;
/
update XXSP_EWAYBILL_CHALLAN_HDRS
set hsncode = 84713010
where header_id = 21;
/
select * from mtl_system_items_b;
/
SELECT
    hdr.*
FROM
    xxsp_ewaybill_challan_hdrs  hdr,
    xxsp_ewaybill_challan_lines line
WHERE
        1 = 1
    AND hdr.header_id = line.header_id
    AND hdr.challan_num = 'PN/DC/23-24/1';
/
IF ctrl_blk_ctl.transaction_type = 'DC challan' THEN    --Added by Krishna for DC Challan on 31-Jan-2023
    SELECT
        line.hsncode
    INTO :parameter.hsn_cnt
    FROM
        xxsp_ewaybill_challan_hdrs  hdr,
        xxsp_ewaybill_challan_lines line
    WHERE
            1 = 1
        AND hdr.header_id = line.header_id
        AND org_id = :ctrl_blk_ctl.organization_id
        AND header_id = :ctrl_blk.customer_trx_id;  -- till here by krishna

ELSE
    SELECT
        COUNT(jtd.hsn_code)
    INTO :parameter.hsn_cnt
    FROM
        jai_tax_det_fct_lines_v jtd
    WHERE
            1 = 1
        AND trx_id = :ctrl_blk.customer_trx_id
        AND trx_line_id IN (
            SELECT
                customer_trx_line_id
            FROM
                ra_customer_trx_lines_all
            WHERE
                    customer_trx_id = :ctrl_blk.customer_trx_id
                AND org_id = :ctrl_blk_ctl.organization_id
                AND line_type = 'LINE'
        )
        AND org_id = :ctrl_blk_ctl.organization_id
        AND jtd.tax_event_class_code = 'SALES_TRANSACTION';

END IF;

IF :parameter.hsn_cnt = 0 THEN
    fnd_message.debug('Invoice should have at least one item belongs to goods. Eway Bill cannot generate against this invoice.');
    RAISE form_trigger_failure;
END IF;



/
SELECT
    trx_id
FROM
    jai_tax_lines
WHERE
        tax_invoice_num = 'PN/DC/23-24/1' --p_tax_invoice_num
    AND entity_code = 'TRANSACTIONS'
/
SELECT
    '{
    "itemNo": "'
    || l.seq_no
    || '",
        "productName": "'
    || l.product_name
    || '",
        "productDesc": "'
    || l.product_desc
    || '",
        "hsnCode":  "'
    || l.hsncode
    || '",
        "quantity": '
    || l.quantity
    || ',
        "qtyUnit":  "'
    || l.unit_of_measure
    || '",
        "taxableAmount": '
    || l.value_of_goods
    || '
        "sgstrate": '
    || l.sgstrate
    || ',
        "cgstrate": '
    || l.cgstrate
    || ',
        "igstRate": '
    || l.igstrate
    || ',
        "cessRate": '
    || l.cessrate
    || ',
        "cessNonAdvol": '
    || l.cessnonadvol
    || '
        }

        ' line
FROM
    apps.xxsp_ewaybill_challan_lines l,
    apps.xxsp_ewaybill_challan_hdrs  h
WHERE
        1 = 1
    AND h.header_id = l.header_id
    AND h.challan_num = :p_tax_invoice_num
    AND ou_org_id = :p_org_id;
/*
and    invoice_id IN (
        SELECT
            trx_id
        FROM
            jai_tax_lines
        WHERE
                tax_invoice_num = p_tax_invoice_num
            AND entity_code = 'TRANSACTIONS'
    )
    AND org_id = p_org_id;
*/
--UNION
SELECT
    '1.1'                          AS version1,
    'GST'                          AS taxsch,
    'B2B'                          supply_type,
    h.header_id                    invoice_id,
    h.doc_type                     invoice_type,
    h.challan_num                  invoice_number,
    h.challan_date                 invoice_date,
    h.dispatch_state               seller_state,
    h.challan_num                  tax_invoice_num,
    h.dispatch_cust_gst            seller_gstin,
    h.dispatch_cust_name           seller_name,
    '01923222773'                  seller_phone,
    h.dispatch_address1            seller_address1,
    h.dispatch_address2            seller_address2,
    h.dispatch_city                seller_city,
    h.dispatch_postal_code         seller_postal_code,
    h.dispatch_statecode           seller_state_code,
    'info@sudhirpower.com'         seller_email,
    h.bill_to_cust_gst             buyer_gstin,
    h.bill_to_cust_name            buyer_name,
    h.bill_to_state                buyer_state,
    h.bill_to_address1             buyer_address1,
    h.bill_to_address2             buyer_address2,
    h.bill_to_city                 buyer_city,
    h.bill_to_postal_code          buyer_postal_code,
    substr(bill_to_cust_gst, 1, 2) buyer_pos,
    999999999                      buyer_phone,
    'customer@gmail.com'           buyer_email,
    h.ship_to_cust_gst             buyer_ship_to_gstin,
    h.ship_to_cust_name            buyer_ship_to_name,
    h.ship_to_address1             buyer_ship_to_address1,
    h.ship_to_address2             buyer_ship_to_address2,
    h.ship_to_city                 buyer_ship_to_city,
    h.ship_to_postal_code          buyer_ship_to_postal,
    substr(ship_to_cust_gst, 1, 2) buyer_ship_to_state_code,
    l.cgstrate                     cgst_amount,
    0                              utgst_amount,
    l.igstrate                     igst_amount,
    h.total_value                  net_amount,
    h.total_value_of_goods         tax_amount,
    h.total_value                  gross_amount,
    h.ou_org_id                    org_id,
    h.challan_num                  shipbno,
    h.challan_date                 shipbdt,
    'IN'                           cntcode,
    'INR'                          forcur,
    NULL                           ref_inv_no,
    NULL                           ref_inv_date,
    NULL                           delivery_no,
    NULL                           delivery_date,
    'INR'                          invoice_currency_code,
    'IN'                           buyer_country,
    h.eway_bill_status,
    h.eway_bill_num                ceway_bill_no,
    NULL                           irn
FROM
    apps.xxsp_ewaybill_challan_hdrs  h,
    apps.xxsp_ewaybill_challan_lines l
WHERE
        1 = 1
    AND h.header_id = l.header_id
    and h.CHALLAN_NUM = 'PN/DC/23-24/3';
/
select * from xx_ewaybill_data order by id desc--where IDINVOICE_NUMBER = 'PN/DC/23-24/1';
/
 SELECT COUNT (jtd.hsn_code) --into :parameter.HSN_CNT
      FROM jai_tax_det_fct_lines_v jtd
     WHERE     1 = 1
           AND trx_id = :CTRL_BLK.CUSTOMER_TRX_ID
           AND trx_line_id IN
                  (SELECT CUSTOMER_TRX_LINE_ID
                     FROM ra_customer_trx_lines_all
                    WHERE     customer_trx_id = :CTRL_BLK.CUSTOMER_TRX_ID
                          AND org_id = :CTRL_BLK_CTL.ORGANIZATION_ID
                          AND line_type = 'LINE')
           AND org_id = :CTRL_BLK_CTL.ORGANIZATION_ID
           AND jtd.tax_event_class_code = 'SALES_TRANSACTION';
           
  IF :parameter.HSN_CNT = 0 THEN
      fnd_message.debug('Invoice should have at least one item belongs to goods. Eway Bill cannot generate against this invoice.');  
    raise form_trigger_failure;
  END IF;  
/
    SELECT
        COUNT(line.hsncode)
--    INTO :parameter.hsn_cnt
    FROM
        xxsp_ewaybill_challan_hdrs  hdr,
        xxsp_ewaybill_challan_lines line
    WHERE
            1 = 1
        AND hdr.header_id = line.header_id
        AND hdr.OU_ORG_ID = :ctrl_blk_ctl.organization_id -- 342
        AND line.SEQ_NO = :ctrl_blk.customer_trx_id;  -- 2 till here by krishna
/

SELECT
      invoice_date,
      invoice_number,
      tax_invoice_num,
      invoice_id,
      buyer_ship_to_name                                                                                                           customer_name
      ,
      buyer_ship_to_address1                                                                                                       customer_address1
      ,
      buyer_ship_to_address2                                                                                                       customer_address2
      ,
      buyer_ship_to_city                                                                                                           customer_city
      ,
      buyer_ship_to_postal                                                                                                         customer_pincode
      ,
      buyer_ship_to_state_code,
      buyer_ship_to_state_code,
      buyer_gstin,
      seller_name,
      seller_address1,
      seller_address2,
      seller_city,
      seller_postal_code,
      seller_state_code,
      seller_state_code,
      seller_gstin,
      nvl(eway_bill_status, 'Not Generated')                                                                                       AS
      eway_bill_status,
      eway_bill_no,
      ceway_bill_no,
      ( net_amount )                                                                                                               total_price
      ,
      ( nvl(utgst_amount, 0) )                                                                                                     sgstval
      ,
      ( nvl(cgst_amount, 0) )                                                                                                      cgstval
      ,
      ( nvl(igst_amount, 0) )                                                                                                      igstval
      ,
      nvl(gross_amount, 0) - nvl(net_amount, 0) - ( ( nvl(utgst_amount, 0) ) + ( nvl(
      cgst_amount, 0) ) + ( nvl(igst_amount, 0) ) ) tax_amount,
      gross_amount,
      irn,
      BUYER_CITY
    FROM
      xxewaybill_rec_v
    WHERE
    1 = 1
    AND invoice_number = nvl(:v_invoice_no, invoice_number)
    AND tax_invoice_num = nvl(:v_gst_invoice_no, tax_invoice_num)
    AND buyer_ship_to_name = nvl(:p_customer_name, buyer_ship_to_name)
    AND nvl(eway_bill_status, 'Not Generated') = nvl(:p_eway_bill_status,
                                  nvl(eway_bill_status, 'Not Generated'))
--    AND invoice_date BETWEEN nvl(:p_gl_date_from,invoice_date) AND nvl(:p_gl_date_to,invoice_date)
    AND invoice_type = :p_transaction_type --'INV'
    AND org_id = :p_organization_id;
/
SELECT
                lookup_code sub_supply_type_code,
                description sub_supply_type_desc
--            INTO
--                :xx_eway_bill_part_a_header.sub_supply_type_code,
--                :xx_eway_bill_part_a_header.sub_supply_type_desc
            FROM
                fnd_lookups
            WHERE
                lookup_type LIKE 'XX_EWAY_BILL_SUB_SUPPLY_TYPE'
                AND lookup_code in (1,8);
/
UPDATE xxsp_ewaybill_challan_hdrs
SET
--    attribute1 = to_char(sysdate),
--    eway_bill_num = 321009269187,
--    eway_bill_status = 'Generated'--initcap('${input.EWAY_BILL_STATUS}')
    attribute3 = to_char('11/02/202411:59:00PM')--, 'DD/MM/YYYY HH:MM:SS')
WHERE
    challan_num = 'PN/DC/23-24/4'
/
select * from xx_eway_bill_part_a_header;
/
desc xx_eway_bill_part_a_header;
/
select length ('SPL GGN Rental Division Operating Unit') from dual;
alter table XXSP_EWAYBILL_CHALLAN_HDRS
modify ATTRIBUTE3 varchar2(60);
/
select * from xx_ewaybill_data where INVOICE_NUMBER = 'PN/DC/23-24/7'
--order by P_EWAYBILL_DATE desc;
/
select * from  apps.XXSP_EWAYBILL_CHALLAN_HDRS where CHALLAN_NUM = 'PN/DC/23-24/10';
;
update apps.XXSP_EWAYBILL_CHALLAN_HDRS 
set SHIP_TO_POSTAL_CODE = '301019'
where CHALLAN_NUM = 'PN/DC/23-24/10';
/
select * from  xxsp_ewaybill_challan_hdrs where  HEADER_ID = 85;
/
select * from xx_eway_bill_part_a_header where EWAY_BILL_NO = 391009275651;
/
SELECT
   *-- COUNT(*)
--INTO v_count
FROM
    xx_eway_bill_part_b
WHERE
    eway_bill_part_a_header_id = 137784--:xx_eway_bill_part_a_header.eway_bill_part_a_header_id;
/
SELECT
    COUNT(*)
--INTO v_count
FROM
    xx_eway_bill_part_a_header
WHERE
    eway_bill_part_a_header_id IN (
        SELECT
            MAX(eway_bill_part_a_header_id)
        FROM
            xx_eway_bill_part_a_header
        WHERE
            ar_invoice = 'PN/DC/23-24/10'--:ctrl_blk.ar_invoice
    );
/
SELECT
    COUNT(*)
--INTO v_count
FROM
    xx_eway_bill_part_a_lines
WHERE
    eway_bill_part_a_header_id = :xx_eway_bill_part_a_header.eway_bill_part_a_header_id;
/
SELECT TRANSPORTER_ID --INTO V_TRANSPORTER_ID 
FROM XX_EWAY_BILL_PART_A_HEADER WHERE CUSTOMER_TRX_ID = 85-- :CTRL_BLK.CUSTOMER_TRX_ID 
AND EWAY_BILL_PART_A_HEADER_ID = (SELECT MAX(EWAY_BILL_PART_A_HEADER_ID) FROM XX_EWAY_BILL_PART_A_HEADER 
WHERE AR_INVOICE = 'PN/DC/23-24/10' );--:CTRL_BLK.AR_INVOICE);
--IF V_TRANSPORTER_ID IS NOT NULL OR :CTRL_BLK.EWAY_BILL_STATUS ='Associated' THEN
/
desc xxsp_ewaybill_challan_hdrs;
/
select * from ra_customer_trx_all order by creation_date desc;
/
select PERIOD_NAME from gl_periods where sysdate between START_DATE
/
SELECT
    period_name
FROM
    gl_periods
WHERE
    trunc(sysdate) BETWEEN trunc(start_date) AND trunc(end_date)
    AND adjustment_period_flag = 'N'
    AND period_set_name = 'SGL_Calendar';/    
    SELECT
                year_start_date                    from_date,
                add_months(year_start_date, 3) - 1 to_date,--,year_end_date
                end_date                           period_end_date
--            INTO
--                from_date,
--                to_date,
--                period_end_date
            FROM
                gl_period_statuses
            WHERE
                    period_name = :p_period_name
                AND ROWNUM = 1;--'APR-23';
/
select * from xxrostan_b2cinvoice_header_stg where TAX_INVOICE_NUM = 'GST119250007';
invoice_number = '10013';
/
XXROSTAN_B2C_INV_PKG
/
select * from xxb2cinvoice_header_v2_new where 1 = 1
and invoice_number = '10013'
--and TAX_INVOICE_NUM = 'GST119250007';