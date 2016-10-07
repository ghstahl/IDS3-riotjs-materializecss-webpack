import * as nprogress from 'nprogress';
import 'nprogress/nprogress.css'
import RiotControl from 'riotcontrol';

<loading-indicator>

    this.on('mount', function() {
        var self = this;
        RiotControl.on('progress_start', function() {
            nprogress.start();
        });
        RiotControl.on('progress_done', function() {
            nprogress.done();
        });
    });
</loading-indicator>