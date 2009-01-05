Mire használható ez a plugin?
=============================

A ZipcodeMatch egy, a magyarországi irányítószámok és települések egyezőségét ellenőrző plugin. Valójában ennél többre is képes, mivel adatbázisa tartalmazza minden magyarországi település és a hozzá tartozó irányítószámot vagy irányítószámokat így kiválóan felhasználható űrlapok adatbevitelének az ellenőrzésére vagy segítésére.

A kiegészítő egy [Rails szakdolgozat](http://szakdolgozat.csiszarattila.com) melléktermékeként jött létre.

Telepítés
=========

Plugin telepítése
-----------------
Egyszerűen parancssorból kiadva az alkalmazás könyvtárában:

  script/plugin install git://github.com/csiszarattila/zipcodematch.git

Adatok importálása
------------------
Az egyszerűbb használat érdekében a kiterjesztés az adatokat adatbázisban tárolja, az adatbázist pedig egy Zipcode nevű ActiveRecord típusú modellen keresztül éri el. A modell használatához így egy migrációval előbb létre kell hozni a szükséges zipcodes elnevezésű táblát, ezt a plugin generátorával könnyen megteheted:

  script/generate zipcodes table

Majd töltsük fel a létrehozott sémát:

  rake db:migrate
  
Majd az adatok beimportálásához az adatbázis táblába futtasd:
  
  rake db:zipcodes:load

(Légy türelemmel, ez a művelet eltarthat egy ideig.)

Példák
======
Az ellenőrzésre a __ZipcodeMatch.match?(település,irányítószám)__ használhatjuk, amely eldönti, hogy a megadott település és irányítószám összetartozik-e (figyelembe veszi, hogy egyes városok több irányítószámmal is rendelkezhetnek).

Érdemes alacsony szintű ellenőrzésként alkalmazni egy modellben:

  def validate
  	unless ZipcodeMatch::match?(self.city, self.zipcode)
  		errors.add_to_base ...
  	end
  end

vagy használd a magasabb szintű validációk egyikét:

  class Address < ActiveRecord::Base
    ...
    validates_zipcode_and_city_match
    ...
  end

API
===
A ZipcodeMatch modul metódusai
------------------------------

<table>
  <tr>
    <th>ZipcodeMatch osztálymetódus</th>
    <th>Mire használható?</th>
  </tr>
  <tr>
    <td>match?(település,irányítószám)</td>
    <td>Annak eldöntése, hogy a település és irányítószám egyezik-e</td>
  </tr>
  <tr>
    <td>city_exist?(település)</td>
    <td>Annak eldöntésére, hogy a megadott település létezik-e</td>
  </tr>
  <tr>
    <td>zipcode_exist?(irányítószám)</td>
    <td>Mint az előző csak irányítószám esetében</td>
  </tr>
  <tr>
    <td>city_with_zipcode(irányítószám)</td>
    <td>Visszaadja az adott irányítószámhoz tartozó települést</td>
  </tr>
  <tr>
    <td>zipcodes_for_city(település)</td>
    <td>Megkeresi az adott településhez tartozó irányítószámo(ka)t</td>
  </tr>
</table>

Rake taszkok
------------
A db és zipcode névtéren belül a load (db:zipcodes:load) betölti, a delete (db:zipcodes:delete) pedig kitörli az adatokat az adatbázis táblából.

ActiveRecordos magasabb szintű validációk
-----------------------------------------
Az ellenőrzések egyszerűsítéshez az ActiveRecord modellek esetében a plugin definiál néhány magasabb szintű ellenőrzést is.

A validates_zipcode_and_city_match két mező viszonylatában ellenőrzi a település és hozzá tartozó irányítószám egyezését:
  
  class Address < ActiveRecord::Base
    ...
    validates_zipcode_and_city_match
    ...
  end
  
A hibaüzeneteket mindig a modellhez és nem az attribútumokhoz társítja! Alapértelmezettként a :city és :zipcode attributumokat használja fel. Ez megváltoztatható az opciókkal, többek között itt adhatjuk azt is meg, hogy mikor alkalmazza az ellenőrzést - alapértelmezettként a mentés során futtatja a validációt.

  validates_zipcode_and_city_match :zipcode_attr_is=>:ir, :city_attr_is=>:varos, :on => :create

A validates_existence_on segítségével vagy a modellhez tartozó települést vagy az irányítószámot vizsgálhatjuk meg, hogy érvényes-e. Használatához jellezzük a metódusnak első attribútumként, hogy melyiket szeretnénk vizsgálni:

Települések esetében a :city szimbólummal
  
  validates_existence_on :city, :message => "Ilyen nevű település nem létezik!"
  
Irányítószámok esetében a :zipcode szimbólummal

  validates_existence_on :zipcode, :message => "Ilyen irányítószám nem létezik!"
  
Az alapértelmezett attribútum ezúttal is a city vagy a zipcode elnevezésű lesz, ezt felülbírálni az  :attr_is_ opcióval lehetséges:

  validates_existence_on :city, :attr\_is => :varos

Milyen adatokkal dolgozik?
==========================
[A Magyar Posta weboldaláról](http://www.posta.hu/object.a4c06249-c686-4d95-b333-08b467959979.ivy) letölhető az összes Magyarországi irányítószám és a hozzá tartozó cím XLS formátumban. Az adatok adatbázisban való tárolásához ezt előbb CSV formátumba konvertáltam, majd az adatbázisba töltéskor csak az irányítószám és a hozzá tartozó település került mentésre (az adatforrás több, számunkra szükségtelen adatot is tartalmaz). 

Ez egyben azt is jelenti, hogy egyes településekhez több irányítószám is tartozhat. A budapesti irányítószámok esetében pedig minden irányítószám mellett Budapest szerepel mint város, a kerületeket pedig nem veszi figyelembe. Ha ezen változtatni szeretnél a ZipcodeMatch.import_from_csv metódust tekintsd meg, ez végzi el az irányítószámok adatbázisba töltését - a db:zipcodes:load rake taszk pedig ezt hívja meg.

Hogyan futtassuk a modellek unit tesztjeit
==========================================
Problémát jelenthet, hogy a modellek egység-tesztjeinél bizonyos esetekben lefuthatnak a validációk megbolondítva ezzel a tesztek kimeneteit.

A gondot az okozza, hogy a tesztek futtatásakor a Rails kitöröl minden táblát és az fixtureszekkel(alapadatokkal) tölti fel azokat a teszt adatbázisban, így az alapadatokon kívül nem lehet saját, előre definiált adatokkal feltölteni. Viszont így a ZipcodeMatch modul sem találja az adatbázisban a szükséges adatokat.

Ennek feloldására próbálkozhatunk az irányítószámok fixtures-ként való megadásával - elfogadja a CSV formátumot is - ez azonban jelentősen lelassíthatja a tesztek futtatását, mivel minden teszt futtatása előtt a tesztkörnyezet újratölti az alapadatokat. 

Ezért inkább érdemes létrehozni egy, a ZipcodeMatch modult imitáló úgynevezett mock osztályt, ami tulajdonképpen csak felülírja a modul eredeti metódusait, hogy mindig igaz értékkel térjenek vissza.

Egy ilyen mock objektumot megtalálsz a plugin mellett, mindössze includold be annak modellnek a unit test fájljában, amelyik használja a plugin metódusait:

  require 'zipcodematch/lib/mocks/zipcode_match.rb'

  class AddressTest < ActiveSupport::TestCase
  ...
  end
  
Ezzel a teszteket függetleníthetjük a ZipcodeMatch modultól, amelynek működése külön tesztekkel van biztosítva - lásd plugin/ok/konyvtara/zipcodematch/test/ könyvtárt.

Copyright (c) 2008 Csiszár Attila, released under the MIT license

email: csiszar pont ati kukac gmail pont com
www: [csiszarattila.com](http://csiszarattila.com)
