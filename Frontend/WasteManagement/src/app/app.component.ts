import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';
import { HttpClient } from '@angular/common/http'
@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'WasteManagement';

  constructor(private httpClient: HttpClient) {

  }

  login() {
    // this.httpClient.get('https://localhost:44311/api/User').subscribe(data => console.log(data))
  }
}
