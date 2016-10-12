import * as nprogress from 'nprogress';
import 'nprogress/nprogress.css'
import RiotControl from 'riotcontrol';

<loading-indicator>

    <script>
        var self = this;
        self.onProgressStart = () =>{
            nprogress.start();
        }
        self.onProgressDone = () =>{
            nprogress.done();
        }
        self.on('mount', function() {
            console.log('loading-indicator mount......')
            RiotControl.on('progress_start', self.onProgressStart);
            RiotControl.on('progress_done', self.onProgressDone);
        });

        self.on('unmount', function() {
            console.log('loading-indicator unmount......')
            RiotControl.off('progress_start', self.onProgressStart);
            RiotControl.off('progress_done', self.onProgressDone);
        });

    </script>
</loading-indicator>