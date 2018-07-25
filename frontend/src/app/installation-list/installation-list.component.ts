import { Component, Input } from "@angular/core";
import { Observable } from "rxjs";

@Component({
  templateUrl: "./installation-list.component.html",
  selector: "installation-list",
  styleUrls: ["./installation-list.component.scss"]
})
export class InstallationList {
  @Input() installations$: Observable<any>[];
}
