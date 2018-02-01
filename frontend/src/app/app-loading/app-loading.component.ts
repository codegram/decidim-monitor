import { Component, Input } from "@angular/core";

@Component({
  templateUrl: "./app-loading.component.html",
  styleUrls: ["./app-loading.component.scss"],
  selector: "app-loading"
})
export class AppLoading {
  @Input() loading: Boolean;
}
