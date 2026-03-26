import 'Trailers.dart';
import 'Movie.dart';

final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Avengers: Endgame',
    posterUrl: 'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/a1b015e3-37b5-4bfa-b530-2e3009c04e1a/dd31j5z-535b7812-81e4-4d7a-acd6-0bf263a6bfd9.jpg/v1/fill/w_787,h_1015,q_70,strp/avengers_endgame_poster_by_ralfmef_dd31j5z-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MjMyMCIsInBhdGgiOiJcL2ZcL2ExYjAxNWUzLTM3YjUtNGJmYS1iNTMwLTJlMzAwOWMwNGUxYVwvZGQzMWo1ei01MzViNzgxMi04MWU0LTRkN2EtYWNkNi0wYmYyNjNhNmJmZDkuanBnIiwid2lkdGgiOiI8PTE4MDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.TowSnJjKXBCXXwyKvglACfTlAbIHZCodJxEtjd7_V-Q',
    overview: 'In 2018, 23 days after Thanos erased half of all life in the universe,[a] Carol Danvers rescues Tony Stark and Nebula from deep space. They reunite with the remaining Avengers—Bruce Banner, Steve Rogers, Thor, Natasha Romanoff, and James Rhodes—and Rocket on Earth. Finding Thanos on an uninhabited planet, they plan to use the Infinity Stones to reverse his actions but learn that Thanos has destroyed them. Enraged, Thor decapitates Thanos.',
    genres: ['Action, Science Fiction, Adventure'],
    rating: 9.6,
    trailers: [
      Trailers(
        id: 't1',
        title: 'Official Trailers',
        thumbnailUrl: 'https://tse3.mm.bing.net/th/id/OIP.t6N73-dty-zMFR2w9LKxUQHaEK?rs=1&pid=ImgDetMain&o=7&rm=3',
        videoUrl: 'https://youtu.be/TcMBFSGVi1c',
      ),
      Trailers(
        id: 't2',
        title: 'Behind the Scenes',
        thumbnailUrl: 'https://tse3.mm.bing.net/th/id/OIP.W-JOZbNmGcIqE5YqgljnzgHaHa?w=853&h=853&rs=1&pid=ImgDetMain&o=7&rm=3',
        videoUrl: 'https://www.youtube.com/watch?v=ucpF-NRR220&t=3s',
      ),
    ],
  ),

  Movie(
      id: '2',
      title: 'Iron Man (2008)',
      posterUrl: 'https://wallpaperaccess.com/full/1508549.jpg',
      overview: 'Iron Man (2008) is a superhero film that follows the story of Tony Stark, a billionaire industrialist and genius inventor who is kidnapped and forced to build a devastating weapon. Instead of using it to cause evil, Stark uses his intelligence and ingenuity to create a high-tech suit of armor that he uses to escape captivity and fight against global threats.',
      genres: ['Action, Science Fiction, Adventure'],
      rating: 8.5,
      trailers: [
        Trailers(
          id: 't3',
          title: 'Official Trailers',
          thumbnailUrl: 'https://i.ytimg.com/vi/Qdnv0liW7vc/maxresdefault.jpg',
          videoUrl: 'https://youtu.be/8ugaeA-nMTc',
        ),
        Trailers(
          id: 't4',
          title: 'Behind the Scenes',
          thumbnailUrl: 'https://i.ytimg.com/vi/8ugaeA-nMTc/maxresdefault.jpg',
          videoUrl: 'https://www.youtube.com/watch?v=6IeunEjo4lw',
        ),
      ]
  ),

  Movie(
      id: '3',
      title: 'Iron Man 3',
      posterUrl: 'https://townsquare.media/site/442/files/2013/02/iron_man_3_poster_stark_armor.jpg',
      overview: 'At a New Years Eve party in 1999, Tony Stark meets scientist Maya Hansen, the inventor of Extremis, '
          'an experimental regenerative treatment that allows recovery from crippling injuries. Disabled scientist Aldrich Killian offers them a place in his company Advanced Idea Mechanics (A.I.M.), but Stark rejects him. Thirteen years later, Stark is suffering from post-traumatic stress disorder and has frequent panic attacks due to his experiences during the alien invasion of New York.[b] He has built dozens of new Iron Man suits to cope with his insomnia, creating friction with his girlfriend Pepper Potts.',
      genres: ['Action, Science Fiction, Adventure'],
      rating: 9.0,
      trailers: [
        Trailers(
          id: 't5',
          title: 'Official Trailers',
          thumbnailUrl: 'https://tse3.mm.bing.net/th/id/OIP.jZvfyAhH1UD-djKnSXywIwHaKc?w=503&h=709&rs=1&pid=ImgDetMain&o=7&rm=3',
          videoUrl: 'https://youtu.be/YLorLVa95Xo',
        ),
        Trailers(
            id: 't6',
            title: 'Behind the Scenes',
            thumbnailUrl: 'https://tse3.mm.bing.net/th/id/OIP.3nDgh8jZH6z5ucB9ri1pOQHaE6?rs=1&pid=ImgDetMain&o=7&rm=3',
            videoUrl: 'https://youtu.be/ZSu4ZRqXidM',
        ),
      ]
  ),

  Movie(
      id: '4',
      title: 'Captain America: The First Avenger',
      posterUrl: 'https://artfiles.alphacoders.com/973/thumb-800-97386.webp',
      overview: 'Steve Rogers was a frail young man who wanted to serve his country during World War II. He volunteered for a secret experiment called the Super-Soldier Program, which transformed him into a peak human specimen—stronger, faster, and more resilient than ordinary humans.',
      genres: ['Action, Adventure, War, Drama'],
      rating: 8.0,
      trailers: [
        Trailers(
          id: 't7',
          title: 'Official Trailers',
          thumbnailUrl: 'https://tse3.mm.bing.net/th/id/OIP.NbwU9AnnZAVzfjpc7PkcaAHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
          videoUrl: 'https://youtu.be/PQRHZmgmKuA',
        ),
        Trailers(
          id: 't8',
          title: 'Behind the Scenes',
          thumbnailUrl: 'https://th.bing.com/th/id/OIP.2Jlzj8-y2jwyxra3mjEcDQHaEK?w=276&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
          videoUrl: 'https://youtu.be/Xqnq8o_5yWY',
        ),
      ],
  ),
];