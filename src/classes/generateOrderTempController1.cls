public class generateOrderTempController1 
{

	 public order__c currentOrder {get;set;}
 	 //constructor
 	 public generateOrderTempController1(ApexPages.standardController con) {
  	 	currentOrder = new order__c();}
      //fetch dishes based on the input
      public void fetchDishes() {
          //Initialize variables
          List < String > allValues = new List < String > ();
          Integer countOfOnes = 0;
          Integer countOfTwos = 0;
          Integer countOfThrees = 0;
          Integer countOfFours = 0;
          Set<Integer> finalListToBeQueried = new Set<Integer>();
          Boolean isError = false;
          Boolean check = false;
          String errorMessage = '';
          Map<Integer,String> dishNumDishNameMap = new Map<Integer,String>();
          String finalOutputString = '';
          List<String> finalInputList = new List<String>();
          allValues = currentOrder.Input__c.split(',');
          //get first value
          String timeOfDay = allValues[0].trim();
          allValues.remove(0);
          System.debug('timeOfDay: ' + timeOfDay);
            if (timeOfDay.equalsIgnoreCase('morning')){
             //fetch rest of the dish item values 
             if (!allValues.isEmpty()) {
             for (String dishNum: allValues) {
             dishNum = dishNum.trim();
             if (dishNum.equals('1')) {
                  countOfOnes++;
                 //Only one order of entree is allowed
                    if (countOfOnes > 1) {
                                            isError = true;
                                            errorMessage = 'Only one Entree (#1) order is allowed';
                                            break;
                                        }
                                    } 
                                else if (dishNum.equals('2'))
                                {
                                        countOfTwos++;
                                        if (countOfTwos > 1)
                                        {
                                            isError = true;
                                            errorMessage = 'Only one Side (#2) order is allowed';
                                            break;
                                        } 
                                } 
                                else if (dishNum.equals('3')) 
                                {
                                        countOfThrees++;
                                    
                                        
                                }
                                else if (dishNum.equals('4')) 
                                {
                                        //countOfFours++;
                                        //if (countOfFours > 1) {
                                        isError = true;
                                        errorMessage = 'Desert(#4) is not available in the Morning';
                                        break;
                                       //}
                                }
                            
                                else 
                                {
                                        isError = true;
                                        errorMessage = 'Only Menu Items 1, 2, 3 are allowed';
                                        break;
                                } 
          					   //generate input dish numbers array
                              if (isError == false)
                              {
                                 
                                    finalListToBeQueried.add(Integer.valueOf(dishNum));
                                    finalInputList.add(dishNum);
                              }
                        }
                            
                    }
                    else if(allValues.isEmpty())
                    {
                             isError = true;
                             errorMessage = 'Minimum One order is required';
                    }
                }
          		else if(timeOfDay.equalsIgnoreCase('night'))
                {
                    
                    if (!allValues.isEmpty()) 
                    {
                        for (String dishNum: allValues) 
                        {
                            dishNum = dishNum.trim();
                                if (dishNum.equals('1')) 
                                    {
                                        countOfOnes++;
                                        if (countOfOnes > 1) 
                                        {
                                            isError = true;
                                            errorMessage = 'Only one Entree (#1) order is allowed';
                                            break;
                                        }
                                    } 
                                else if (dishNum.equals('2')) 
                                {
                                        countOfTwos++;
                                           
                                }
                                else if (dishNum.equals('3'))
                                {
                                        countOfThrees++;
                                        if (countOfThrees > 1)
                                        {
                                            isError = true;
                                            errorMessage = 'Only one Drink (#3) order is allowed';
                                            break;
                                        } 
                                } 
                                
                                else if (dishNum.equals('4')) 
                                {
                                        countOfFours++;
                                        if (countOfFours > 1)
                                        {
                                            isError = true;
                                            errorMessage = 'Only one Desert (#4) order is allowed';
                                            break;
                                        }
                                } 
                                else 
                                {
                                        isError = true;
                                        errorMessage = 'Only Menu Items 1, 2, 3,4 are allowed';
                                        break;
                                }
          					   //generate input dish numbers array
                              if (isError == false)
                              {
                                 
                                    finalListToBeQueried.add(Integer.valueOf(dishNum));
                                    finalInputList.add(dishNum);
                              }
                        
    
         				}
                            
                    }
                    else if(allValues.isEmpty())
                    {
                             isError = true;
                             errorMessage = 'Minimum One order is required';
                    }
                }
          		else  
         		{
          			isError = true;
                    errorMessage = 'Only morning or night is allowed';
            	}
          //******************************************Generating the Output Values************************************************************
                            List < Dishes__c > allDishes = new List < Dishes__c > ();
          //query the name of the dish from DB
                            allDishes = [Select Id,Name,Dish_Number__c,Dish_Type__c,Time_Of_Day__c From Dishes__c Where Time_Of_Day__c = :timeOfDay AND Dish_Number__c IN :finalListToBeQueried];
                            for(Dishes__c dish:allDishes)
                            {
                                 if (countOfThrees > 1 & Integer.valueOf(dish.Dish_Number__c) == 3)
                                 {
                                     String dishName = dish.Name + '(x'+ countOfThrees + ')';
                                     dishNumDishNameMap.put(Integer.valueOf(dish.Dish_Number__c),dishName);
                                     
                                }
                                else if(countOfTwos > 1 & Integer.valueOf(dish.Dish_Number__c) == 2)
                                {
                                    String dishName = dish.Name + '(x'+ countOfTwos + ')';
                                     dishNumDishNameMap.put(Integer.valueOf(dish.Dish_Number__c),dishName);
                                }
                                else
                                {
                                    dishNumDishNameMap.put(Integer.valueOf(dish.Dish_Number__c),dish.Name);
                                }
                                
                            }
     						 List<String> finalOutputList = new List<String>();
                             //putting the output string into finaloutputstring          
                             for(String dishNum1: finalInputList)
                             {
                                 if(finalOutputString == '')
                                  { 
                                      finalOutputString = dishNumDishNameMap.get(Integer.valueOf(dishNum1.trim()));
                                  }
                                 else
                                  {
                                      if (!finalOutputString.contains(dishNumDishNameMap.get(Integer.valueOf(dishNum1.trim()))))
                                      finalOutputString += ', '+dishNumDishNameMap.get(Integer.valueOf(dishNum1.trim()));
                                  }
                            }
          //We need to display any error message encountered by user or the output string
     if (isError==false)
     currentOrder.output__c = finalOutputString;
    else
     currentOrder.output__c = errorMessage;
    }
}