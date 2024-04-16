# pop a works

    Code
      print(output)
    Output
         PopulationName Year     S     R estimate     se lower upper prop_lgt1
      1               A 1989 0.885 0.060    0.941 0.0412 0.876 1.040     0.081
      2               A 1990 0.891 0.102    0.992 0.0337 0.931 1.070     0.382
      3               A 1991 0.886 0.125    1.010 0.0412 0.946 1.110     0.614
      4               A 1992 0.935 0.150    1.100 0.0485 1.030 1.220     0.997
      5               A 1993 0.861 0.113    0.971 0.0392 0.908 1.060     0.240
      6               A 1994 0.811 0.082    0.883 0.0301 0.836 0.953     0.002
      7               A 1995 0.854 0.073    0.921 0.0312 0.868 0.990     0.015
      8               A 1996 0.909 0.070    0.977 0.0359 0.924 1.070     0.227
      9               A 1997 0.757 0.084    0.826 0.0406 0.763 0.917     0.002
      10              A 1998 0.887 0.072    0.956 0.0365 0.901 1.040     0.151
      11              A 1999 0.913 0.101    1.020 0.0544 0.947 1.170     0.656
      12              A 2000 0.810 0.120    0.920 0.0556 0.835 1.050     0.097
      13              A 2001 0.893 0.111    1.000 0.0492 0.935 1.130     0.543
      14              A 2002 0.801 0.071    0.862 0.0426 0.802 0.968     0.009
      15              A 2003 0.777 0.080    0.845 0.0369 0.784 0.931     0.000
      16              A 2004 0.960 0.066    1.030 0.0414 0.976 1.140     0.823
      17              A 2005 0.840 0.076    0.909 0.0385 0.852 1.000     0.028
      18              A 2006 0.652 0.056    0.691 0.0333 0.632 0.765     0.000
      19              A 2007 0.821 0.055    0.869 0.0326 0.816 0.943     0.002
      20              A 2008 0.679 0.112    0.765 0.0368 0.701 0.840     0.000
      21              A 2009 0.852 0.045    0.892 0.0285 0.845 0.963     0.003
      22              A 2010 0.868 0.066    0.929 0.0376 0.869 1.020     0.054
      23              A 2011 0.918 0.062    0.979 0.0339 0.923 1.060     0.253
      24              A 2012 0.924 0.078    1.000 0.0397 0.946 1.100     0.528
      25              A 2013 0.903 0.116    1.020 0.0458 0.951 1.130     0.683
      26              A 2014 0.908 0.088    0.996 0.0416 0.937 1.100     0.461
      27              A 2015 1.000 0.128    1.150     NA    NA    NA        NA
                ran_s        ran_r
      1  0.885393.... 0.093371....
      2  0.887638.... 0.092485....
      3  0.863758.... 0.105889....
      4  0.927429.... 0.096823....
      5  0.864785.... 0.104181....
      6  0.816777.... 0.079039....
      7  0.833591.... 0.148512....
      8  0.903778.... 0.066836....
      9  0.719454.... 0.074539....
      10 0.882565.... 0.102178....
      11 0.929996.... 0.101805....
      12 0.827479.... 0.127758....
      13 0.889128.... 0.138949....
      14 0.820015.... 0.081138....
      15 0.791475.... 0.058924....
      16 0.960971.... 0.093179....
      17 0.819966.... 0.145305....
      18 0.647301.... 0.023799....
      19 0.838768.... 0.049782....
      20 0.690005.... 0.126051....
      21 0.840941.... 0.052464....
      22 0.826231.... 0.109978....
      23 0.907291.... 0.023838....
      24 0.885476.... 0.072609....
      25 0.882295.... 0.087886....
      26 0.902239.... 0.058347....
      27 NaN, NaN.... 0.135225....

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

# pop b works

    Code
      print(output)
    Output
         PopulationName Year     S     R estimate     se lower upper prop_lgt1
      1               B 2003 0.779 0.084    0.850 0.1510 0.771 1.360     0.162
      2               B 2004 0.932 0.093    1.030 0.0220 0.987 1.080     0.911
      3               B 2005 0.878 0.060    0.934 0.0313 0.891 1.020     0.040
      4               B 2006 0.761 0.048    0.799 0.0358 0.740 0.881     0.000
      5               B 2007 0.618 0.077    0.670 0.0523 0.582 0.796     0.000
      6               B 2008 0.851 0.114    0.960 0.0533 0.880 1.080     0.222
      7               B 2009 1.000 0.110    1.120     NA    NA    NA        NA
      8               B 2010 0.677 0.077    0.733 0.0303 0.681 0.797     0.000
      9               B 2011 0.898 0.103    1.000 0.0343 0.946 1.080     0.529
      10              B 2012 0.927 0.141    1.080 0.0436 1.010 1.180     0.984
      11              B 2013 0.962 0.123    1.100 0.0364 1.040 1.180     0.999
      12              B 2014 0.926 0.088    1.020 0.0333 0.959 1.090     0.701
      13              B 2015 0.925 0.077    1.000 0.0295 0.952 1.070     0.545
      14              B 2016 1.000 0.091    1.100     NA    NA    NA        NA
      15              B 2017 0.891 0.089    0.978 0.0349 0.921 1.060     0.265
                ran_s        ran_r
      1  0.779337.... 0.024847....
      2  0.929945.... 0.084119....
      3  0.857465.... 0.066502....
      4  0.746324.... 0.034144....
      5  0.628254.... 0.054550....
      6  0.860484.... 0.057797....
      7  NaN, NaN.... 0.124938....
      8  0.668947.... 0.100707....
      9  0.868875.... 0.069450....
      10 0.923326.... 0.166821....
      11 0.972427.... 0.128638....
      12 0.935909.... 0.121234....
      13 0.921347.... 0.092815....
      14 NaN, NaN.... 0.047353....
      15 0.902978.... 0.103444....

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

# pop c works

    Code
      print(output)
    Output
        PopulationName Year     S     R estimate     se lower upper prop_lgt1
      1              C 2004 0.867 0.096    0.959 0.0492 0.884 1.080     0.202
      2              C 2005 0.832 0.080    0.904 0.0454 0.827 1.010     0.031
      3              C 2006 1.000 0.068    1.070     NA    NA    NA        NA
      4              C 2007 0.458 0.059    0.487 0.0769 0.428 0.689     0.006
      5              C 2008 0.941 0.083    1.030 0.0578 0.954 1.180     0.722
      6              C 2009 1.000 0.140    1.160     NA    NA    NA        NA
      7              C 2010 0.926 0.158    1.100 0.1110 0.981 1.400     0.935
      8              C 2011 0.960 0.112    1.080 0.0513 1.010 1.200     0.995
      9              C 2012 0.924 0.133    1.070 0.0526 0.982 1.190     0.928
               ran_s        ran_r
      1 0.867449.... 0.066122....
      2 0.827343.... 0.049265....
      3 NaN, NaN.... 0.066019....
      4 0.442467.... 0.107850....
      5 0.945812.... 0.162811....
      6 NaN, NaN.... 0.234456....
      7 0.904194.... 0.125470....
      8 0.955802.... 0.145061....
      9 0.893533.... 0.115362....

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

# test data works

    Code
      print(output)
    Output
        PopulationName Year   S    R estimate     se lower upper prop_lgt1
      1              C 2003 0.5 0.01    0.505 0.0514 0.408 0.605     0.000
      2              C 2004 0.7 0.02    0.714 0.0452 0.654 0.826     0.001
      3              C 2005 0.9 0.02    0.918 0.0532 0.836 1.030     0.057
      4              C 2006 1.0 0.03    1.030     NA    NA    NA        NA
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
