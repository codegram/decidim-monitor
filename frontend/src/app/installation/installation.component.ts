import { Component, OnInit, Input } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { map, startWith } from 'rxjs/operators';
import semver from 'semver';

@Component({
  selector: 'app-installation',
  templateUrl: './installation.component.html',
  styleUrls: []
})
export class InstallationComponent implements OnInit {
  @Input() installation: any;
  color: string;

  ngOnInit() {
    let version = this.installation.version;
    let currentVersion = this.installation.currentVersion;

    try {
      let major = semver.major(version);
      let minor = semver.minor(version);
      let patch = semver.patch(version);

      let currentMajor = semver.major(currentVersion);
      let currentMinor = semver.minor(currentVersion);
      let currentPatch = semver.patch(currentVersion);

      if(semver.satisfies(`${major}.${minor}.${patch}`, `=${currentMajor}.${currentMinor}.${currentPatch}`)) {
        this.color = "primary";
      } else if(semver.satisfies(`${major}.${minor}.${patch}`, `>=${currentMajor}.${currentMinor}.x`)) {
        this.color = "accent";
      } else {
        this.color = "warn";
      }
    } catch(e) {
      this.color = "warn";
    }
  }
}
