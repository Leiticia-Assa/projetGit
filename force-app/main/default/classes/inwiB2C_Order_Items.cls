public with sharing class inwiB2C_Order_Items {
        
    public static List<InwiB2C_Promotion__c> SearchForPromotion  ( ID  Order_Item_Id  )       
    {
		
		List<Account> lst_accs = new List<Account>  () ; 
        List<InwiB2C_Promotion__c>  lst_promotion =  new List <InwiB2C_Promotion__c> () ;
        List<InwiB2C_scop_determinant__c>  lst_scop_determinant =  new List <InwiB2C_scop_determinant__c> () ;    
        List<InwiB2C_determinant__c>  lst_determinant =  new List <InwiB2C_determinant__c> () ;
        
        
       	list<Order> orders = [select id , Order.AccountId  , ordernumber , inwiB2C_canal__c , inwiB2C_type_offer__c , 
           type from Order where id =: Order_Item_Id        ];
		system.debug(orders); 
        
        for ( order a :orders  )
        {

	 	lst_accs.add ( [select id, name from account where Id =:  a.accountid ] );
        system.debug(lst_accs);

            /*
            
      	lst_promotion.add( [select id , Name ,  InwiB2C_code_promotion__c  ,  InwiB2C_libelle_promotion__c ,
                            InwiB2C_type_promotion__c ,InwiB2C_code_produit__c      from  InwiB2c_Promotion__c  ]  )   ;   
     
		lst_scop_determinant.add ( [ select id , Name   ,  InwiB2c_Type_d_inclution__c , InwiB2c_Type_acte_de_gestion__c , 
                                     InwiB2c_canal__c , InwiB2c_promotion_discount__c        from  InwiB2c_scop_determinant__c  ]  )   ;      
                         
		lst_determinant.add( [   select id , Name   ,  InwiB2c_Scope__c , InwiB2c_code_produit__c , InwiB2c_code_attribute__c , InwiB2c_field__c  , inwiB2C_value__c ,
         inwiB2C_scope_determinant__c  from  InwiB2c_determinant__c          ] ) ; 
            
            
           if ( lst_promotion.size() > 0   )
               
           {         
               
              system.debug(lst_promotion);
          
   
           }
*/
		
		}




        
return lst_promotion  ;

 	   }
}    
        
// promotion => scope determinant   => determinant ( if  champ scope  !?= 'order' ) => code attribut , field ( order ) , value