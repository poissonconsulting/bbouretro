# NA instead in dataset work

    Code
      print(output)
    Output
        PopulationName Year   S    R estimate     se lower upper prop_lgt1
      1              C 2007 0.5 0.01    0.505 0.0514 0.408 0.605     0.000
      2              C 2008 0.7 0.02    0.714 0.0452 0.654 0.826     0.001
      3              C 2009 0.9 0.02    0.918 0.0532 0.836 1.030     0.057
      4              C 2010 1.0 0.03    1.030     NA    NA    NA        NA
               ran_s        ran_r
      1 0.500937.... 0.002587....
      2 0.694443.... 0.077748....
      3 0.850701.... 0.031005....
      4 NaN, NaN.... 0.006496....

---

    Code
      print(check_df_class(output))
    Output
      PopulationName           Year              S              R       estimate 
         "character"      "integer"      "numeric"      "numeric"      "numeric" 
                  se          lower          upper      prop_lgt1          ran_s 
           "numeric"      "numeric"      "numeric"      "numeric"         "AsIs" 
               ran_r 
              "AsIs" 

