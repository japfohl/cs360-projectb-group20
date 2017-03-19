<!-- Primary Page Layout
–––––––––––––––––––––––––––––––––––––––––––––––––– -->
<div class="section-top">
    <div class="container">
        <h1 style="text-align: center;"><a href="../public/home.php"><?php echo $appname; ?></a></h1>
        <form method="get" action="../public/getresults.php">
        <div class="row">
            <div class="nine columns">
                <input class="u-full-width" type="search" name="prodname" id="searchbox" placeholder="search product name" value="<?php echo $prodname; ?>"/>
            </div>
            <div class="three columns">
                <input class="u-full-width" type="submit" value="Search"/>
            </div>
        </div>
        </form>
    </div>
</div>
<div class="container">
    <?php if (sizeof($results) == 0): ?>
        <div class="container">
            <div class="row">
                <div class="twelve columns">
                    <h3>No Results Found for <?php echo "'" . $prodname . "'"; ?></h3>
                </div>
            </div>
        </div>
    <?php else: ?>
        <div class="row">
            <div class="twelve columns">
              <h3>Search Results</h3>
            </div>
        </div>
        <?php foreach($results as $r): ?>
        <div class="row">
            <div class="twelve columns">
                <h5><?php echo $r["pname"] . " by " . $r["mname"]; ?></h5>
            </div>
        </div>
        <div class="row">
            <div class="three columns">
                <a href="#" data-photo-id="<?php echo $r["pid"]; ?>">
                    <img class="u-max-full-width" width=200 src="<?php echo $r["purl"]; ?>">
                </a>
            </div>
            <div class="nine columns">
                <div class="row">
                    <div class="twelve columns">
                        <!-- <h5><?php echo $r["mname"]; ?></h5> -->
                        <h5><?php echo "Values-based price:  <b>$" . number_format($r["vcost"], 2); ?></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="twelve columns">
                        <p><?php echo "List price:  <b>$" . number_format($r["pcost"], 2) . "</b>"; ?></p>
                        <p><?php 
                                foreach ($r["cost"] as $key => $value ):
                                    echo "Cost of " . $key . ":  <b>$" . number_format($value, 2) . "</b><br>";
                                endforeach; 
                            ?>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <br>
    <?php endforeach; ?>
    <?php endif; ?>
</div>

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>
</html>
