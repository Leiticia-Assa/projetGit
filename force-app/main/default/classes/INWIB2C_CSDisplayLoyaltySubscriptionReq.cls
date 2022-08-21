public with sharing class INWIB2C_CSDisplayLoyaltySubscriptionReq {
    public CSOperationInfo CSOperationInfo ;
    public CSDisplayLoyaltySubscriptionInteraction CSDisplayLoyaltySubscriptionInteraction;
    
    public class CSOperationInfo{

		public CSOperationInfo(String user,String channel,String uuid){
			this.user = user;
			this.channel = channel;
			this.uuid = uuid;
		}

		String user;
		String channel;
		String uuid;
	}
    
    public class CSDisplayLoyaltySubscriptionInteraction{
		public String id;
        public CSLoyaltyAcount CSLoyaltyAcount;
        
		public CSDisplayLoyaltySubscriptionInteraction(String id,CSLoyaltyAcount CSLoyaltyAcount){
			this.id=id;
            this.CSLoyaltyAcount=CSLoyaltyAcount;
		}
	}
    
	public class CSLoyaltyAcount{
    	public CSCustomer CSCustomer;
        public CSOrder CSOrder;
        public CSLoyaltyAcount(CSCustomer CSCustomer, CSOrder CSOrder){
            this.CSCustomer = CSCustomer;
            this.CSOrder = CSOrder;
        }
    }
    
    public class CSCustomer{
    	public String id;        
        public CSCustomer(String id){
			this.id=id;
		}
    }
    
    public class CSOrder{
       public String captureID; 
       public CSOffer CSOffer;
        public CSOrder(String captureID, CSOffer CSOffer){
            this.captureID = captureID;
            this.CSOffer = CSOffer;
        } 
    }
    
    public class CSOffer{
        public CSProduct CSProduct;
        public CSOffer(CSProduct CSProduct){
            this.CSProduct = CSProduct;
        }
    }
	
    public class CSProduct{
        public CSMobileDirectoryNumber CSMobileDirectoryNumber;
        public CSProduct(CSMobileDirectoryNumber CSMobileDirectoryNumber){
            this.CSMobileDirectoryNumber=CSMobileDirectoryNumber;
        }
    }
    
    public class CSMobileDirectoryNumber{
        public String mdn;
        public CSMobileDirectoryNumber(String mdn){
            this.mdn = mdn;
        }
    }
    
}