import { Component, OnInit, Input } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { map, startWith } from 'rxjs/operators';
import compareVersion from 'node-version-compare';

@Component({
  selector: 'app-installation',
  templateUrl: './installation.component.html',
  styleUrls: ['./installation.component.scss']
})
export class InstallationComponent implements OnInit {
  @Input() installation: any;
  outdated: boolean;
  outdatedColor: string;

  ngOnInit() {
    this.outdated = (compareVersion(this.installation.version, this.installation.currentVersion) < 0);
    this.outdatedColor = this.outdated ? 'warn' : 'primary';
  }
}
