# survival a works

    Code
      print(bbr_survival(bboudata::bbousurv_a, include_uncertain_morts = TRUE,
      variance = "cox_oakes"), n = 100, width = 100)
    Output
      # A tibble: 32 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 A                     1985    1     0     NaN     NaN                8  
       2 A                     1986    1     0     NaN     NaN                8  
       3 A                     1987    0.583 0.04    0.503   0.66             7.2
       4 A                     1988    1     0     NaN     NaN               13.6
       5 A                     1989    0.885 0.021   0.838   0.92            17.3
       6 A                     1990    0.891 0.018   0.85    0.922           22.1
       7 A                     1991    0.886 0.015   0.854   0.912           34.6
       8 A                     1992    0.935 0.012   0.907   0.956           31.5
       9 A                     1993    0.861 0.013   0.832   0.885           47.8
      10 A                     1994    0.811 0.015   0.78    0.839           46.2
      11 A                     1995    0.854 0.016   0.82    0.882           36.8
      12 A                     1996    0.909 0.014   0.877   0.933           31.5
      13 A                     1997    0.757 0.022   0.712   0.797           24.8
      14 A                     1998    0.887 0.017   0.85    0.916           26  
      15 A                     1999    0.913 0.017   0.875   0.94            22.2
      16 A                     2000    0.81  0.024   0.759   0.851           18.8
      17 A                     2001    0.893 0.016   0.857   0.921           27.4
      18 A                     2002    0.801 0.02    0.759   0.837           27  
      19 A                     2003    0.777 0.02    0.734   0.814           27  
      20 A                     2004    0.96  0.011   0.932   0.977           25.6
      21 A                     2005    0.84  0.02    0.797   0.876           23.3
      22 A                     2006    0.652 0.024   0.605   0.697           22.2
      23 A                     2007    0.821 0.02    0.779   0.857           25  
      24 A                     2008    0.679 0.023   0.633   0.721           24.2
      25 A                     2009    0.852 0.018   0.813   0.884           27.2
      26 A                     2010    0.868 0.017   0.832   0.897           30.3
      27 A                     2011    0.918 0.015   0.883   0.944           24.4
      28 A                     2012    0.924 0.015   0.891   0.948           25.5
      29 A                     2013    0.903 0.015   0.87    0.929           29.4
      30 A                     2014    0.908 0.015   0.873   0.934           26.9
      31 A                     2015    1     0     NaN     NaN               26.4
      32 A                     2016    1     0     NaN     NaN               28  
         sum_dead sum_alive status                                                 
            <int>     <int> <chr>                                                  
       1        0        16 Only 2 months monitored; No Mortalities all year (SE=0)
       2        0        96 No Mortalities all year (SE=0)                         
       3        4        87 <NA>                                                   
       4        0       163 No Mortalities all year (SE=0)                         
       5        2       208 <NA>                                                   
       6        3       265 <NA>                                                   
       7        4       415 <NA>                                                   
       8        2       378 <NA>                                                   
       9        7       573 <NA>                                                   
      10       10       554 <NA>                                                   
      11        6       441 <NA>                                                   
      12        3       378 <NA>                                                   
      13        7       298 <NA>                                                   
      14        3       312 <NA>                                                   
      15        2       266 <NA>                                                   
      16        4       226 <NA>                                                   
      17        3       329 <NA>                                                   
      18        6       324 <NA>                                                   
      19        7       324 <NA>                                                   
      20        1       307 <NA>                                                   
      21        4       280 <NA>                                                   
      22        8       266 <NA>                                                   
      23        5       300 <NA>                                                   
      24        9       290 <NA>                                                   
      25        4       326 <NA>                                                   
      26        4       364 <NA>                                                   
      27        2       293 <NA>                                                   
      28        2       306 <NA>                                                   
      29        3       353 <NA>                                                   
      30        2       323 <NA>                                                   
      31        0       317 No Mortalities all year (SE=0)                         
      32        0        28 Only 1 months monitored; No Mortalities all year (SE=0)
    Code
      print(bbr_survival(bboudata::bbousurv_a, include_uncertain_morts = FALSE,
      variance = "cox_oakes"), n = 100, width = 100)
    Output
      # A tibble: 32 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 A                     1985    1     0     NaN     NaN                8  
       2 A                     1986    1     0     NaN     NaN                8  
       3 A                     1987    0.583 0.04    0.503   0.66             7.2
       4 A                     1988    1     0     NaN     NaN               13.6
       5 A                     1989    0.885 0.021   0.838   0.92            17.3
       6 A                     1990    0.891 0.018   0.85    0.922           22.1
       7 A                     1991    0.886 0.015   0.854   0.912           34.6
       8 A                     1992    0.935 0.012   0.907   0.956           31.5
       9 A                     1993    0.861 0.013   0.832   0.885           47.8
      10 A                     1994    0.811 0.015   0.78    0.839           46.2
      11 A                     1995    0.854 0.016   0.82    0.882           36.8
      12 A                     1996    0.909 0.014   0.877   0.933           31.5
      13 A                     1997    0.757 0.022   0.712   0.797           24.8
      14 A                     1998    0.887 0.017   0.85    0.916           26  
      15 A                     1999    0.913 0.017   0.875   0.94            22.2
      16 A                     2000    0.81  0.024   0.759   0.851           18.8
      17 A                     2001    0.893 0.016   0.857   0.921           27.4
      18 A                     2002    0.801 0.02    0.759   0.837           27  
      19 A                     2003    0.777 0.02    0.734   0.814           27  
      20 A                     2004    0.96  0.011   0.932   0.977           25.6
      21 A                     2005    0.84  0.02    0.797   0.876           23.3
      22 A                     2006    0.652 0.024   0.605   0.697           22.2
      23 A                     2007    0.821 0.02    0.779   0.857           25  
      24 A                     2008    0.679 0.023   0.633   0.721           24.2
      25 A                     2009    0.852 0.018   0.813   0.884           27.2
      26 A                     2010    0.868 0.017   0.832   0.897           30.3
      27 A                     2011    0.918 0.015   0.883   0.944           24.4
      28 A                     2012    0.924 0.015   0.891   0.948           25.5
      29 A                     2013    0.903 0.015   0.87    0.929           29.4
      30 A                     2014    0.908 0.015   0.873   0.934           26.9
      31 A                     2015    1     0     NaN     NaN               26.4
      32 A                     2016    1     0     NaN     NaN               28  
         sum_dead sum_alive status                                                 
            <int>     <int> <chr>                                                  
       1        0        16 Only 2 months monitored; No Mortalities all year (SE=0)
       2        0        96 No Mortalities all year (SE=0)                         
       3        4        87 <NA>                                                   
       4        0       163 No Mortalities all year (SE=0)                         
       5        2       208 <NA>                                                   
       6        3       265 <NA>                                                   
       7        4       415 <NA>                                                   
       8        2       378 <NA>                                                   
       9        7       573 <NA>                                                   
      10       10       554 <NA>                                                   
      11        6       441 <NA>                                                   
      12        3       378 <NA>                                                   
      13        7       298 <NA>                                                   
      14        3       312 <NA>                                                   
      15        2       266 <NA>                                                   
      16        4       226 <NA>                                                   
      17        3       329 <NA>                                                   
      18        6       324 <NA>                                                   
      19        7       324 <NA>                                                   
      20        1       307 <NA>                                                   
      21        4       280 <NA>                                                   
      22        8       266 <NA>                                                   
      23        5       300 <NA>                                                   
      24        9       290 <NA>                                                   
      25        4       326 <NA>                                                   
      26        4       364 <NA>                                                   
      27        2       293 <NA>                                                   
      28        2       306 <NA>                                                   
      29        3       353 <NA>                                                   
      30        2       323 <NA>                                                   
      31        0       317 No Mortalities all year (SE=0)                         
      32        0        28 Only 1 months monitored; No Mortalities all year (SE=0)
    Code
      print(bbr_survival(bboudata::bbousurv_a, include_uncertain_morts = TRUE,
      variance = "greenwood"), n = 100, width = 100)
    Output
      # A tibble: 32 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 A                     1985    1     0     NaN     NaN                8  
       2 A                     1986    1     0     NaN     NaN                8  
       3 A                     1987    0.583 0.165   0.271   0.841            7.2
       4 A                     1988    1     0     NaN     NaN               13.6
       5 A                     1989    0.885 0.076   0.639   0.971           17.3
       6 A                     1990    0.891 0.061   0.703   0.966           22.1
       7 A                     1991    0.886 0.054   0.732   0.956           34.6
       8 A                     1992    0.935 0.044   0.776   0.984           31.5
       9 A                     1993    0.861 0.049   0.735   0.932           47.8
      10 A                     1994    0.811 0.054   0.684   0.895           46.2
      11 A                     1995    0.854 0.055   0.71    0.933           36.8
      12 A                     1996    0.909 0.05    0.753   0.97            31.5
      13 A                     1997    0.757 0.08    0.571   0.88            24.8
      14 A                     1998    0.887 0.061   0.703   0.963           26  
      15 A                     1999    0.913 0.059   0.711   0.978           22.2
      16 A                     2000    0.81  0.086   0.588   0.927           18.8
      17 A                     2001    0.893 0.058   0.716   0.965           27.4
      18 A                     2002    0.801 0.073   0.622   0.908           27  
      19 A                     2003    0.777 0.074   0.6     0.89            27  
      20 A                     2004    0.96  0.039   0.765   0.994           25.6
      21 A                     2005    0.84  0.073   0.643   0.939           23.3
      22 A                     2006    0.652 0.099   0.443   0.816           22.2
      23 A                     2007    0.821 0.073   0.635   0.924           25  
      24 A                     2008    0.679 0.088   0.489   0.824           24.2
      25 A                     2009    0.852 0.069   0.665   0.944           27.2
      26 A                     2010    0.868 0.062   0.696   0.949           30.3
      27 A                     2011    0.918 0.055   0.725   0.979           24.4
      28 A                     2012    0.924 0.051   0.743   0.981           25.5
      29 A                     2013    0.903 0.053   0.739   0.968           29.4
      30 A                     2014    0.908 0.063   0.693   0.977           26.9
      31 A                     2015    1     0     NaN     NaN               26.4
      32 A                     2016    1     0     NaN     NaN               28  
         sum_dead sum_alive status                                                 
            <int>     <int> <chr>                                                  
       1        0        16 Only 2 months monitored; No Mortalities all year (SE=0)
       2        0        96 No Mortalities all year (SE=0)                         
       3        4        87 <NA>                                                   
       4        0       163 No Mortalities all year (SE=0)                         
       5        2       208 <NA>                                                   
       6        3       265 <NA>                                                   
       7        4       415 <NA>                                                   
       8        2       378 <NA>                                                   
       9        7       573 <NA>                                                   
      10       10       554 <NA>                                                   
      11        6       441 <NA>                                                   
      12        3       378 <NA>                                                   
      13        7       298 <NA>                                                   
      14        3       312 <NA>                                                   
      15        2       266 <NA>                                                   
      16        4       226 <NA>                                                   
      17        3       329 <NA>                                                   
      18        6       324 <NA>                                                   
      19        7       324 <NA>                                                   
      20        1       307 <NA>                                                   
      21        4       280 <NA>                                                   
      22        8       266 <NA>                                                   
      23        5       300 <NA>                                                   
      24        9       290 <NA>                                                   
      25        4       326 <NA>                                                   
      26        4       364 <NA>                                                   
      27        2       293 <NA>                                                   
      28        2       306 <NA>                                                   
      29        3       353 <NA>                                                   
      30        2       323 <NA>                                                   
      31        0       317 No Mortalities all year (SE=0)                         
      32        0        28 Only 1 months monitored; No Mortalities all year (SE=0)
    Code
      print(bbr_survival(bboudata::bbousurv_a, include_uncertain_morts = FALSE,
      variance = "greenwood"), n = 100, width = 100)
    Output
      # A tibble: 32 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 A                     1985    1     0     NaN     NaN                8  
       2 A                     1986    1     0     NaN     NaN                8  
       3 A                     1987    0.583 0.165   0.271   0.841            7.2
       4 A                     1988    1     0     NaN     NaN               13.6
       5 A                     1989    0.885 0.076   0.639   0.971           17.3
       6 A                     1990    0.891 0.061   0.703   0.966           22.1
       7 A                     1991    0.886 0.054   0.732   0.956           34.6
       8 A                     1992    0.935 0.044   0.776   0.984           31.5
       9 A                     1993    0.861 0.049   0.735   0.932           47.8
      10 A                     1994    0.811 0.054   0.684   0.895           46.2
      11 A                     1995    0.854 0.055   0.71    0.933           36.8
      12 A                     1996    0.909 0.05    0.753   0.97            31.5
      13 A                     1997    0.757 0.08    0.571   0.88            24.8
      14 A                     1998    0.887 0.061   0.703   0.963           26  
      15 A                     1999    0.913 0.059   0.711   0.978           22.2
      16 A                     2000    0.81  0.086   0.588   0.927           18.8
      17 A                     2001    0.893 0.058   0.716   0.965           27.4
      18 A                     2002    0.801 0.073   0.622   0.908           27  
      19 A                     2003    0.777 0.074   0.6     0.89            27  
      20 A                     2004    0.96  0.039   0.765   0.994           25.6
      21 A                     2005    0.84  0.073   0.643   0.939           23.3
      22 A                     2006    0.652 0.099   0.443   0.816           22.2
      23 A                     2007    0.821 0.073   0.635   0.924           25  
      24 A                     2008    0.679 0.088   0.489   0.824           24.2
      25 A                     2009    0.852 0.069   0.665   0.944           27.2
      26 A                     2010    0.868 0.062   0.696   0.949           30.3
      27 A                     2011    0.918 0.055   0.725   0.979           24.4
      28 A                     2012    0.924 0.051   0.743   0.981           25.5
      29 A                     2013    0.903 0.053   0.739   0.968           29.4
      30 A                     2014    0.908 0.063   0.693   0.977           26.9
      31 A                     2015    1     0     NaN     NaN               26.4
      32 A                     2016    1     0     NaN     NaN               28  
         sum_dead sum_alive status                                                 
            <int>     <int> <chr>                                                  
       1        0        16 Only 2 months monitored; No Mortalities all year (SE=0)
       2        0        96 No Mortalities all year (SE=0)                         
       3        4        87 <NA>                                                   
       4        0       163 No Mortalities all year (SE=0)                         
       5        2       208 <NA>                                                   
       6        3       265 <NA>                                                   
       7        4       415 <NA>                                                   
       8        2       378 <NA>                                                   
       9        7       573 <NA>                                                   
      10       10       554 <NA>                                                   
      11        6       441 <NA>                                                   
      12        3       378 <NA>                                                   
      13        7       298 <NA>                                                   
      14        3       312 <NA>                                                   
      15        2       266 <NA>                                                   
      16        4       226 <NA>                                                   
      17        3       329 <NA>                                                   
      18        6       324 <NA>                                                   
      19        7       324 <NA>                                                   
      20        1       307 <NA>                                                   
      21        4       280 <NA>                                                   
      22        8       266 <NA>                                                   
      23        5       300 <NA>                                                   
      24        9       290 <NA>                                                   
      25        4       326 <NA>                                                   
      26        4       364 <NA>                                                   
      27        2       293 <NA>                                                   
      28        2       306 <NA>                                                   
      29        3       353 <NA>                                                   
      30        2       323 <NA>                                                   
      31        0       317 No Mortalities all year (SE=0)                         
      32        0        28 Only 1 months monitored; No Mortalities all year (SE=0)

# survival b works

    Code
      print(bbr_survival(bboudata::bbousurv_b, include_uncertain_morts = TRUE,
      variance = "cox_oakes"), n = 100, width = 100)
    Output
      # A tibble: 18 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 B                     2001    0.889 0.028   0.82    0.933            9.2
       2 B                     2002    0.923 0.015   0.889   0.947           25.5
       3 B                     2003    0.779 0.018   0.742   0.813           33.4
       4 B                     2004    0.932 0.011   0.907   0.95            42.1
       5 B                     2005    0.878 0.014   0.847   0.904           37.6
       6 B                     2006    0.761 0.024   0.712   0.804           20.8
       7 B                     2007    0.618 0.035   0.547   0.684            9.8
       8 B                     2008    0.851 0.025   0.795   0.894           14.2
       9 B                     2009    1     0     NaN     NaN               24.4
      10 B                     2010    0.677 0.022   0.633   0.719           25.8
      11 B                     2011    0.898 0.016   0.863   0.924           28.2
      12 B                     2012    0.927 0.014   0.894   0.95            26.7
      13 B                     2013    0.962 0.011   0.934   0.978           25  
      14 B                     2014    0.926 0.014   0.893   0.949           26.2
      15 B                     2015    0.925 0.015   0.89    0.95            24  
      16 B                     2016    1     0     NaN     NaN               26.8
      17 B                     2017    0.891 0.017   0.853   0.92            24.6
      18 B                     2018    0.636 0       0.636   0.636           27  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        1       110 <NA>                          
       2        2       306 <NA>                          
       3        8       401 <NA>                          
       4        3       505 <NA>                          
       5        5       451 <NA>                          
       6        8       249 <NA>                          
       7        5       118 <NA>                          
       8        2       171 <NA>                          
       9        0       293 No Mortalities all year (SE=0)
      10       10       310 <NA>                          
      11        3       339 <NA>                          
      12        2       320 <NA>                          
      13        1       300 <NA>                          
      14        2       314 <NA>                          
      15        2       288 <NA>                          
      16        0       322 No Mortalities all year (SE=0)
      17        3       295 <NA>                          
      18        1        27 Only 1 months monitored       
    Code
      print(bbr_survival(bboudata::bbousurv_b, include_uncertain_morts = FALSE,
      variance = "cox_oakes"), n = 100, width = 100)
    Output
      # A tibble: 18 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 B                     2001    0.889 0.028   0.82    0.933            9.2
       2 B                     2002    0.923 0.015   0.889   0.947           25.5
       3 B                     2003    0.779 0.018   0.742   0.813           33.4
       4 B                     2004    0.932 0.011   0.907   0.95            42.1
       5 B                     2005    0.878 0.014   0.847   0.904           37.6
       6 B                     2006    0.761 0.024   0.712   0.804           20.8
       7 B                     2007    0.618 0.035   0.547   0.684            9.8
       8 B                     2008    0.851 0.025   0.795   0.894           14.2
       9 B                     2009    1     0     NaN     NaN               24.4
      10 B                     2010    0.677 0.022   0.633   0.719           25.8
      11 B                     2011    0.898 0.016   0.863   0.924           28.2
      12 B                     2012    0.927 0.014   0.894   0.95            26.7
      13 B                     2013    0.962 0.011   0.934   0.978           25  
      14 B                     2014    0.926 0.014   0.893   0.949           26.2
      15 B                     2015    0.925 0.015   0.89    0.95            24  
      16 B                     2016    1     0     NaN     NaN               26.8
      17 B                     2017    0.891 0.017   0.853   0.92            24.6
      18 B                     2018    0.636 0       0.636   0.636           27  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        1       110 <NA>                          
       2        2       306 <NA>                          
       3        8       401 <NA>                          
       4        3       505 <NA>                          
       5        5       451 <NA>                          
       6        8       249 <NA>                          
       7        5       118 <NA>                          
       8        2       171 <NA>                          
       9        0       293 No Mortalities all year (SE=0)
      10       10       310 <NA>                          
      11        3       339 <NA>                          
      12        2       320 <NA>                          
      13        1       300 <NA>                          
      14        2       314 <NA>                          
      15        2       288 <NA>                          
      16        0       322 No Mortalities all year (SE=0)
      17        3       295 <NA>                          
      18        1        27 Only 1 months monitored       
    Code
      print(bbr_survival(bboudata::bbousurv_b, include_uncertain_morts = TRUE,
      variance = "greenwood"), n = 100, width = 100)
    Output
      # A tibble: 18 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 B                     2001    0.889 0.105   0.5     0.985            9.2
       2 B                     2002    0.923 0.052   0.739   0.981           25.5
       3 B                     2003    0.779 0.069   0.616   0.886           33.4
       4 B                     2004    0.932 0.038   0.808   0.978           42.1
       5 B                     2005    0.878 0.051   0.739   0.948           37.6
       6 B                     2006    0.761 0.076   0.584   0.878           20.8
       7 B                     2007    0.618 0.139   0.337   0.837            9.8
       8 B                     2008    0.851 0.097   0.559   0.963           14.2
       9 B                     2009    1     0     NaN     NaN               24.4
      10 B                     2010    0.677 0.084   0.497   0.817           25.8
      11 B                     2011    0.898 0.056   0.726   0.967           28.2
      12 B                     2012    0.927 0.05    0.75    0.982           26.7
      13 B                     2013    0.962 0.038   0.772   0.995           25  
      14 B                     2014    0.926 0.05    0.748   0.981           26.2
      15 B                     2015    0.925 0.051   0.744   0.981           24  
      16 B                     2016    1     0     NaN     NaN               26.8
      17 B                     2017    0.891 0.059   0.711   0.965           24.6
      18 B                     2018    0.636 0       0.636   0.636           27  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        1       110 <NA>                          
       2        2       306 <NA>                          
       3        8       401 <NA>                          
       4        3       505 <NA>                          
       5        5       451 <NA>                          
       6        8       249 <NA>                          
       7        5       118 <NA>                          
       8        2       171 <NA>                          
       9        0       293 No Mortalities all year (SE=0)
      10       10       310 <NA>                          
      11        3       339 <NA>                          
      12        2       320 <NA>                          
      13        1       300 <NA>                          
      14        2       314 <NA>                          
      15        2       288 <NA>                          
      16        0       322 No Mortalities all year (SE=0)
      17        3       295 <NA>                          
      18        1        27 Only 1 months monitored       
    Code
      print(bbr_survival(bboudata::bbousurv_b, include_uncertain_morts = FALSE,
      variance = "greenwood"), n = 100, width = 100)
    Output
      # A tibble: 18 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 B                     2001    0.889 0.105   0.5     0.985            9.2
       2 B                     2002    0.923 0.052   0.739   0.981           25.5
       3 B                     2003    0.779 0.069   0.616   0.886           33.4
       4 B                     2004    0.932 0.038   0.808   0.978           42.1
       5 B                     2005    0.878 0.051   0.739   0.948           37.6
       6 B                     2006    0.761 0.076   0.584   0.878           20.8
       7 B                     2007    0.618 0.139   0.337   0.837            9.8
       8 B                     2008    0.851 0.097   0.559   0.963           14.2
       9 B                     2009    1     0     NaN     NaN               24.4
      10 B                     2010    0.677 0.084   0.497   0.817           25.8
      11 B                     2011    0.898 0.056   0.726   0.967           28.2
      12 B                     2012    0.927 0.05    0.75    0.982           26.7
      13 B                     2013    0.962 0.038   0.772   0.995           25  
      14 B                     2014    0.926 0.05    0.748   0.981           26.2
      15 B                     2015    0.925 0.051   0.744   0.981           24  
      16 B                     2016    1     0     NaN     NaN               26.8
      17 B                     2017    0.891 0.059   0.711   0.965           24.6
      18 B                     2018    0.636 0       0.636   0.636           27  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        1       110 <NA>                          
       2        2       306 <NA>                          
       3        8       401 <NA>                          
       4        3       505 <NA>                          
       5        5       451 <NA>                          
       6        8       249 <NA>                          
       7        5       118 <NA>                          
       8        2       171 <NA>                          
       9        0       293 No Mortalities all year (SE=0)
      10       10       310 <NA>                          
      11        3       339 <NA>                          
      12        2       320 <NA>                          
      13        1       300 <NA>                          
      14        2       314 <NA>                          
      15        2       288 <NA>                          
      16        0       322 No Mortalities all year (SE=0)
      17        3       295 <NA>                          
      18        1        27 Only 1 months monitored       

# survival c works

    Code
      print(bbr_survival(bboudata::bbousurv_c, include_uncertain_morts = TRUE,
      variance = "cox_oakes"), n = 100, width = 100)
    Output
      # A tibble: 11 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 C                     2003    0.576 0.048   0.48    0.666            5.1
       2 C                     2004    0.867 0.024   0.812   0.907           14.6
       3 C                     2005    0.832 0.025   0.778   0.875           15.8
       4 C                     2006    1     0     NaN     NaN               21.2
       5 C                     2007    0.458 0.026   0.408   0.51            13.8
       6 C                     2008    0.941 0.017   0.899   0.966           15.8
       7 C                     2009    1     0     NaN     NaN               18.9
       8 C                     2010    0.926 0.016   0.889   0.951           21.3
       9 C                     2011    0.96  0.011   0.931   0.977           23.8
      10 C                     2012    0.924 0.016   0.888   0.95            22.1
      11 C                     2013    0.112 0       0.112   0.112           24  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        4        61 <NA>                          
       2        2       175 <NA>                          
       3        3       189 <NA>                          
       4        0       254 No Mortalities all year (SE=0)
       5       11       166 <NA>                          
       6        1       189 <NA>                          
       7        0       227 No Mortalities all year (SE=0)
       8        2       256 <NA>                          
       9        1       285 <NA>                          
      10        2       265 <NA>                          
      11        4        24 Only 1 months monitored       
    Code
      print(bbr_survival(bboudata::bbousurv_c, include_uncertain_morts = FALSE,
      variance = "cox_oakes"), n = 100, width = 100)
    Output
      # A tibble: 11 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 C                     2003    0.576 0.048   0.48    0.666            5.1
       2 C                     2004    0.867 0.024   0.812   0.907           14.6
       3 C                     2005    0.832 0.025   0.778   0.875           15.8
       4 C                     2006    1     0     NaN     NaN               21.2
       5 C                     2007    0.458 0.026   0.408   0.51            13.8
       6 C                     2008    0.941 0.017   0.899   0.966           15.8
       7 C                     2009    1     0     NaN     NaN               18.9
       8 C                     2010    0.926 0.016   0.889   0.951           21.3
       9 C                     2011    0.96  0.011   0.931   0.977           23.8
      10 C                     2012    0.924 0.016   0.888   0.95            22.1
      11 C                     2013    0.112 0       0.112   0.112           24  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        4        61 <NA>                          
       2        2       175 <NA>                          
       3        3       189 <NA>                          
       4        0       254 No Mortalities all year (SE=0)
       5       11       166 <NA>                          
       6        1       189 <NA>                          
       7        0       227 No Mortalities all year (SE=0)
       8        2       256 <NA>                          
       9        1       285 <NA>                          
      10        2       265 <NA>                          
      11        4        24 Only 1 months monitored       
    Code
      print(bbr_survival(bboudata::bbousurv_c, include_uncertain_morts = TRUE,
      variance = "greenwood"), n = 100, width = 100)
    Output
      # A tibble: 11 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 C                     2003    0.576 0.169   0.259   0.841            5.1
       2 C                     2004    0.867 0.088   0.595   0.966           14.6
       3 C                     2005    0.832 0.089   0.588   0.945           15.8
       4 C                     2006    1     0     NaN     NaN               21.2
       5 C                     2007    0.458 0.113   0.257   0.674           13.8
       6 C                     2008    0.941 0.057   0.68    0.992           15.8
       7 C                     2009    1     0     NaN     NaN               18.9
       8 C                     2010    0.926 0.05    0.748   0.981           21.3
       9 C                     2011    0.96  0.039   0.765   0.994           23.8
      10 C                     2012    0.924 0.051   0.743   0.981           22.1
      11 C                     2013    0.112 0       0.112   0.112           24  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        4        61 <NA>                          
       2        2       175 <NA>                          
       3        3       189 <NA>                          
       4        0       254 No Mortalities all year (SE=0)
       5       11       166 <NA>                          
       6        1       189 <NA>                          
       7        0       227 No Mortalities all year (SE=0)
       8        2       256 <NA>                          
       9        1       285 <NA>                          
      10        2       265 <NA>                          
      11        4        24 Only 1 months monitored       
    Code
      print(bbr_survival(bboudata::bbousurv_c, include_uncertain_morts = FALSE,
      variance = "greenwood"), n = 100, width = 100)
    Output
      # A tibble: 11 x 10
         PopulationName CaribouYear estimate    se   lower   upper mean_monitored
         <chr>                <int>    <dbl> <dbl>   <dbl>   <dbl>          <dbl>
       1 C                     2003    0.576 0.169   0.259   0.841            5.1
       2 C                     2004    0.867 0.088   0.595   0.966           14.6
       3 C                     2005    0.832 0.089   0.588   0.945           15.8
       4 C                     2006    1     0     NaN     NaN               21.2
       5 C                     2007    0.458 0.113   0.257   0.674           13.8
       6 C                     2008    0.941 0.057   0.68    0.992           15.8
       7 C                     2009    1     0     NaN     NaN               18.9
       8 C                     2010    0.926 0.05    0.748   0.981           21.3
       9 C                     2011    0.96  0.039   0.765   0.994           23.8
      10 C                     2012    0.924 0.051   0.743   0.981           22.1
      11 C                     2013    0.112 0       0.112   0.112           24  
         sum_dead sum_alive status                        
            <int>     <int> <chr>                         
       1        4        61 <NA>                          
       2        2       175 <NA>                          
       3        3       189 <NA>                          
       4        0       254 No Mortalities all year (SE=0)
       5       11       166 <NA>                          
       6        1       189 <NA>                          
       7        0       227 No Mortalities all year (SE=0)
       8        2       256 <NA>                          
       9        1       285 <NA>                          
      10        2       265 <NA>                          
      11        4        24 Only 1 months monitored       

