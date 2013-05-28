/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment.sync;

/**
 * The flat file column definitions.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public enum ColumnDef {
    
    WS_000_EXT_ENTITY_PROV_ID(9), 
    WS_000_EXT_ENTITY_NPI(10), 
    WS_000_EXT_ENTITY_NAME(35), 
    WS_000_EXT_ENTITY_LEGAL_NAME(35), 
    WS_000_EXT_ENTITY_PROV_TYPE(2), 
    WS_000_EXT_ENTITY_MIDDLE_NAME(35), 
    WS_000_EXT_ENTITY_SSN(9), 
    WS_000_EXT_ENTITY_BIRTH_DATE(10), 
    WS_000_EXT_ENTITY_DEGREE(1), 
    WS_000_EXT_ENTITY_DEGREE_DATE(10), 
    WS_000_EXT_ENTITY_FIRST_NAME(35), 
    WS_000_EXT_ENTITY_LAST_NAME(35), 
    WS_000_EXT_ENTITY_ST_TAX_ID(7), 
    WS_000_EXT_ENTITY_FEIN(9), 
    WS_000_EXT_ENTITY_FSCL_YR_END(10), 
    WS_000_EXT_ENTITY_EFT_VEND_N(10), 
    WS_000_EXT_ENTITY_VEND_LOC(03), 
    WS_000_EXT_OWN_I_OWNER(1), 
    WS_000_EXT_OWN_A_BCKGRD_NAM(35), 
    WS_000_EXT_OWN_A_BCKGRD_OWN(1), 
    WS_000_EXT_PROV_P_E_STAT_DT(10), 
    WS_000_EXT_PROV_P_ENRL_STAT(1), 
    WS_000_EXT_PROV_P_RESV_IND(1), 
    WS_000_EXT_PROV_P_CO_CODE(3), 
    WS_000_EXT_PROV_P_RISK_LVL(1), 
    WS_000_EXT_CONT_I_PHONE(10), 
    WS_000_EXT_CONT_I_FAX(10), 
    WS_000_EXT_CONT_I_EMAIL(70), 
    WS_000_EXT_PRAC_ADDR_1(28), 
    WS_000_EXT_PRAC_ADDR_2(28), 
    WS_000_EXT_PRAC_ADDR_CITY(18), 
    WS_000_EXT_PRAC_ADDR_STATE(02), 
    WS_000_EXT_PRAC_ADDR_ZIP(05), 
    WS_000_EXT_PRAC_ADDR_COUNTY(30), 
    WS_000_EXT_LIC_SPEC_TYPE(2), 
    WS_000_EXT_LIC_TYPE(2), 
    WS_000_EXT_LIC_NBR(13), 
    WS_000_EXT_LIC_BEG_DATE(10), 
    WS_000_EXT_LIC_END_DATE(10), 
    WS_000_EXT_LIC_STATE(2), 
    WS_000_EXT_LIC_STAT(1), 
    WS_000_EXT_LIC_ISSUE_BRD(9), 
    WS_000_EXT_COS_START_DATE(10), 
    WS_000_EXT_COS_END_DATE(10), 
    WS_000_EXT_COS_CODE(3), 
    WS_000_EXT2_OWN_B_PROV_ID(9), 
    WS_000_EXT2_OWN_B_NPI(10), 
    WS_000_EXT2_OWN_B_INT_PCT(3), 
    WS_000_EXT2_OWN_B_BIRTH_DATE(10), 
    WS_000_EXT2_OWN_B_HIRE_DATE(10), 
    WS_000_EXT2_OWN_B_M_NAME(35), 
    WS_000_EXT2_OWN_B_F_NAME(35), 
    WS_000_EXT2_OWN_B_L_NAME(35), 
    WS_000_EXT2_OWN_B_SSN(9), 
    WS_000_EXT2_OWN_B_ROLE_IND_1(1), 
    WS_000_EXT2_OWN_B_ROLE_IND_2(1), 
    WS_000_EXT2_OWN_B_ROLE_IND_3(1), 
    WS_000_EXT2_OWN_B_ROLE_IND_4(1), 
    WS_000_EXT2_OWN_B_FEIN(9), 
    HEADER_MODE(1), 
    HEADER_PROFILE_ID(22), 
    HEADER_LEGACY_ID(8), 
    HEADER_SYS_ERR(2), 
    HEADER_DATA_ERR(30);

    /**
     * The width of the field.
     */
    private int width;
    
    /**
     * Gets the value of the field <code>width</code>.
     * @return the width
     */
    public int getWidth() {
        return width;
    }

    private ColumnDef(int width) {
        this.width = width;
    }
}
