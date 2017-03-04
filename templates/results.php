<!-- Primary Page Layout
–––––––––––––––––––––––––––––––––––––––––––––––––– -->
<div class="container">
    <?php foreach($results as $r): ?>
        <div class="row">
            <div class="twelve columns">
                <h3><?php echo $r["pname"]; ?></h3>
            </div>
        </div>
        <div class="row">
            <div class="six columns">
                <a href="#" data-photo-id="<?php echo $p["pid"]; ?>">
                    <img class="u-max-full-width" src="<?php echo $r["purl"]; ?>">
                </a>
            </div>
            <div class="six columns">
                <div class="row">
                    <div class="twelve columns">
                        <h5><?php echo $r["mname"]; ?></h5>
                    </div>
                </div>
                <div class="row">
                    <div class="twelve columns">
                        <p><?php echo $r["pcost"]; ?></p>
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
