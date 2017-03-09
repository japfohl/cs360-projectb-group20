<!-- Primary Page Layout
–––––––––––––––––––––––––––––––––––––––––––––––––– -->
<div class="container">
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
            <div class="three columns">
                <div class="row">
                    <div class="twelve columns">
                        <!-- <h5><?php echo $r["mname"]; ?></h5> -->
                        <h5><?php echo "Values-based price:  <b>$" . $r["vcost"]; ?></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="twelve columns">
                        <p><?php echo "List price:  <b>$" . $r["pcost"] . "</b>"; ?></p>
                        <p><?php 
                                //$fullcost = $r["pcost"];
                                foreach ($r["cost"] as $key => $value ):
                                    echo "Cost of " . $key . ":  <b>$" . $value . "</b><br>";
                                    //$fullcost += $value;
                                endforeach; 
                            ?>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    <?php endforeach; ?>
</div>

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>
</html>
