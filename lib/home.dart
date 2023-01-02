import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:firebase_auth/firebase_auth.dart';



class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List treandingmvies = [];
  List topratedmovies = [];
  List nowplaying = [];

  final String key = '';
  final token = '';

  void initState(){
    loadmovies();
    super.initState();
  }


  loadmovies()async{
    TMDB tmdbcostumLogs = TMDB(ApiKeys(key, token),
    logConfig: ConfigLogger(
      showLogs: true,
      showErrorLogs: true
    ));
    Map trending = await tmdbcostumLogs.v3.trending.getTrending();
    Map rated = await tmdbcostumLogs.v3.movies.getTopRated();
    Map now = await tmdbcostumLogs.v3.movies.getNowPlaying();

    setState(() {
      treandingmvies = trending['results'];
      topratedmovies = rated['results'];
      nowplaying = now['results'];
    });
      }

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
         backgroundColor: Colors.white,
        appBar: AppBar(title: Text('Flutter1',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('Trending Movies',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 270,
                        child: ListView.builder(itemCount:treandingmvies.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){

                          return InkWell(
                            onTap: (){},
                            child: Container(
                              width: 140,
                              child: Column(
                                children: [
                                  Container(
                                     height:200,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage('https://image.tmdb.org/t/p/w500'+treandingmvies[index]['poster_path']),
                                      )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(child: Text(treandingmvies[index]['title'].toString()!=null?treandingmvies[index]['title'].toString():'--'),),
                                  )
                                  ],
                              ),
                            ),
                          );
                        })
                      ),
                    ),

                  ],

                ),
              ),
              Divider(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Top Ratedmovies',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          height: 270,
                          child: ListView.builder(itemCount:topratedmovies.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){

                                return InkWell(
                                  onTap: (){},
                                  child: Container(
                                    width: 140,
                                    child: Column(
                                      children: [
                                        Container(
                                          height:200,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage('https://image.tmdb.org/t/p/w500'+topratedmovies[index]['poster_path']),
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Container(child: Text(topratedmovies[index]['title'].toString()!=null?topratedmovies[index]['title'].toString():'--'),),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Now Playing',style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          height: 270,
                          child: ListView.builder(itemCount:nowplaying.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){

                                return InkWell(
                                  onTap: (){},
                                  child: Container(
                                    width: 140,
                                    child: Column(
                                      children: [
                                        Container(
                                          height:200,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage('https://image.tmdb.org/t/p/w500'+nowplaying[index]['poster_path']),
                                              )
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Container(child: Text(nowplaying[index]['title'].toString()!=null?nowplaying[index]['title'].toString():'--'),),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
         floatingActionButton: FloatingActionButton(
           onPressed: ()async{
             await FirebaseAuth.instance.signOut();
           },
           child: Icon(Icons.logout),
         ),
      );

  }
}
