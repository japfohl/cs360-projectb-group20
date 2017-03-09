<!-- Primary Page Layout
–––––––––––––––––––––––––––––––––––––––––––––––––– -->
<div class="section-top">
    <div class="container">
        <h1><a href="../public/home.php"><?php echo $appname; ?></a></h1>
        <form method="get" action="../public/getresults.php">
        <div class="row">
            <div class="nine columns">
                <input class="u-full-width" type="search" name="prodname" id="searchbox" placeholder="search product name"/>
             </div>
             <div class="three columns">
                <input class="u-full-width" type="submit" value="Search"/>
             </div>
        </div>
        </form>
    </div>
</div>

<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>
</html>
