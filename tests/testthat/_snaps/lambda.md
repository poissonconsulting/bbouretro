# NA instead in dataset work

    Code
      print(bbr_lambda(recruitment_est, survival_est), n = 100, width = 100)
    Output
      # A tibble: 4 x 11
        PopulationName  Year     S     R estimate      se  lower  upper prop_lgt1
        <chr>          <int> <dbl> <dbl>    <dbl>   <dbl>  <dbl>  <dbl>     <dbl>
      1 C               2007   0.5  0.01    0.505  0.0514  0.408  0.605   0      
      2 C               2008   0.7  0.02    0.714  0.0452  0.654  0.826   0.00100
      3 C               2009   0.9  0.02    0.918  0.0532  0.836  1.03    0.0570 
      4 C               2010   1    0.03    1.03  NA      NA     NA      NA      
        ran_s         ran_r        
        <I<list>>     <I<list>>    
      1 <dbl [1,000]> <dbl [1,000]>
      2 <dbl [1,000]> <dbl [1,000]>
      3 <dbl [1,000]> <dbl [1,000]>
      4 <dbl [1,000]> <dbl [1,000]>

