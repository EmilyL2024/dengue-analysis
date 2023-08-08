### Code Description:

 #### results and visualization.rmd:
  - This file contains three parts:
    - The first part is where the results of the research are generated into a table with information about training and testing datasets,  
      their sensitivity, specificity, PPV (positive predictive values), NPV (negative predictive values), and AUC (area under the curve) 
      values.
      - The results include the in-sample performance of the model, which is training and testing the model on the same dataset, the 
        generalizability of the model, which is to train the model on one dataset and test it on another, and the re-assessed performance 
        of the model with age-restricted datasets, where training and testing data have the same age range
      - Each of the results described above is summarized in a separate table accordingly
    
    - The second part is visualization, which converts the table generated in the first part into graphs for better readability and easier 
      interpretation of the results.

    - The third part is summarizing the statistics, including the range, mean, and median, of each dataset into a professionally formatted 
      table for submission to the journal

 #### calibration_plot.rmd:
  - This file makes calibration plots for each dataset to evaluate the concurrence between the predicted probabilities from our model with  
    the actual probabilities of the datasets
       
