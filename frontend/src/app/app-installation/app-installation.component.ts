import { Component, OnInit, Input } from "@angular/core";
import { Observable } from "rxjs/Observable";
import { map, startWith } from "rxjs/operators";
const semver = require("semver");

@Component({
  selector: "app-installation",
  templateUrl: "./app-installation.component.html",
  styleUrls: ["./app-installation.component.scss"]
})
export class InstallationComponent implements OnInit {
  @Input() installation: any;
  status: string;

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

      if (
        semver.satisfies(
          `${major}.${minor}.${patch}`,
          `=${currentMajor}.${currentMinor}.${currentPatch}`
        )
      ) {
        this.status = "up-to-date";
      } else if (
        semver.satisfies(
          `${major}.${minor}.${patch}`,
          `>=${currentMajor}.${currentMinor}.x`
        )
      ) {
        this.status = "same-minor";
      } else {
        this.status = "outdated";
      }
    } catch (e) {
      this.status = "outdated";
    }
  }
}
